// Netlify function: receives a photo, asks Google Gemini what food is in it,
// and sends back a simple list. If one model is busy, it tries a backup.
exports.handler = async function (event) {
  if (event.httpMethod !== "POST") {
    return { statusCode: 405, body: JSON.stringify({ error: "Use POST" }) };
  }

  const key = process.env.GEMINI_API_KEY;
  if (!key) {
    return { statusCode: 500, body: JSON.stringify({ error: "Missing GEMINI_API_KEY in Netlify" }) };
  }

  let body;
  try {
    body = JSON.parse(event.body);
  } catch (err) {
    return { statusCode: 400, body: JSON.stringify({ error: "Bad request" }) };
  }

  const prompt =
    "List the food items you can see in this photo of a fridge or pantry. " +
    "For each item give a short simple lowercase name (singular, like 'egg', 'milk', 'tomato') " +
    "and a rough guess of how many days it will stay good from today. " +
    'Reply ONLY with a JSON array like [{"name":"milk","days":5}]. Skip anything that is not food.';

  const requestBody = JSON.stringify({
    contents: [
      {
        parts: [
          { text: prompt },
          { inline_data: { mime_type: body.mimeType || "image/jpeg", data: body.image } }
        ]
      }
    ],
    generationConfig: { responseMimeType: "application/json" }
  });

  // Main model first, lighter backup second
  const models = ["gemini-flash-latest", "gemini-flash-lite-latest"];
  let lastError = "unknown error";

  for (const model of models) {
    try {
      const res = await fetch(
        "https://generativelanguage.googleapis.com/v1beta/models/" + model + ":generateContent",
        {
          method: "POST",
          headers: { "Content-Type": "application/json", "x-goog-api-key": key },
          body: requestBody
        }
      );

      const data = await res.json();

      if (res.ok) {
        const text = data.candidates[0].content.parts[0].text;
        const items = JSON.parse(text);
        return {
          statusCode: 200,
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ items: items })
        };
      }

      lastError = (data.error && data.error.message) || ("status " + res.status);

      // Only try the backup if the problem is "busy" or "limit reached"
      if (res.status !== 503 && res.status !== 429 && res.status !== 500) {
        break;
      }
    } catch (err) {
      lastError = err.message;
    }
  }

  return { statusCode: 502, body: JSON.stringify({ error: "Google said: " + lastError }) };
};
