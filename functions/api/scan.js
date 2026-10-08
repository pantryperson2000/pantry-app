// Cloudflare Pages Function: receives a photo, asks Google Gemini what food is in it.
// The API key stays here on the server (set as GEMINI_API_KEY in Cloudflare).
export async function onRequestPost(context) {
  const key = context.env.GEMINI_API_KEY;
  const json = (obj, status) =>
    new Response(JSON.stringify(obj), { status: status || 200, headers: { "Content-Type": "application/json" } });

  if (!key) return json({ error: "Missing GEMINI_API_KEY in Cloudflare" }, 500);

  let body;
  try {
    body = await context.request.json();
  } catch (err) {
    return json({ error: "Bad request" }, 400);
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
        const items = JSON.parse(data.candidates[0].content.parts[0].text);
        return json({ items: items });
      }

      lastError = (data.error && data.error.message) || ("status " + res.status);
      if (res.status !== 503 && res.status !== 429 && res.status !== 500) break;
    } catch (err) {
      lastError = err.message;
    }
  }

  return json({ error: "Google said: " + lastError }, 502);
}
