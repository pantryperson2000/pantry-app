// Netlify function: receives a photo, asks Google Gemini what food is in it,
// and sends back a simple list. The API key stays here on the server.
exports.handler = async function (event) {
  if (event.httpMethod !== "POST") {
    return { statusCode: 405, body: JSON.stringify({ error: "Use POST" }) };
  }

  const key = process.env.GEMINI_API_KEY;
  if (!key) {
    return { statusCode: 500, body: JSON.stringify({ error: "Missing GEMINI_API_KEY in Netlify" }) };
  }

  try {
    const body = JSON.parse(event.body);
    const prompt =
      "List the food items you can see in this photo of a fridge or pantry. " +
      "For each item give a short simple lowercase name (singular, like 'egg', 'milk', 'tomato') " +
      "and a rough guess of how many days it will stay good from today. " +
      'Reply ONLY with a JSON array like [{"name":"milk","days":5}]. Skip anything that is not food.';

    const res = await fetch(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent",
      {
        method: "POST",
        headers: { "Content-Type": "application/json", "x-goog-api-key": key },
        body: JSON.stringify({
          contents: [
            {
              parts: [
                { text: prompt },
                { inline_data: { mime_type: body.mimeType || "image/jpeg", data: body.image } }
              ]
            }
          ],
          generationConfig: { responseMimeType: "application/json" }
        })
      }
    );

    const data = await res.json();
    if (!res.ok) {
      return { statusCode: 502, body: JSON.stringify({ error: "Google said: " + (data.error && data.error.message || res.status) }) };
    }

    const text = data.candidates[0].content.parts[0].text;
    const items = JSON.parse(text);
    return { statusCode: 200, headers: { "Content-Type": "application/json" }, body: JSON.stringify({ items: items }) };
  } catch (err) {
    return { statusCode: 500, body: JSON.stringify({ error: "Something went wrong: " + err.message }) };
  }
};
