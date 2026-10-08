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

  const out = await askGemini(key, requestBody);
  if (!out.ok) return json({ error: out.error }, out.status);
  try {
    return json({ items: JSON.parse(out.text) });
  } catch (err) {
    return json({ error: "Couldn't read the AI's answer. Please try again." }, 502);
  }
}

// Asks Gemini, spreading the load: several models, a couple of quick retries each.
// This makes "high demand" errors much rarer, though it can't remove them completely.
async function askGemini(key, requestBody) {
  const models = ["gemini-flash-latest", "gemini-flash-lite-latest", "gemini-2.5-flash", "gemini-2.5-flash-lite"];
  const start = Date.now();
  let busy = false;
  let lastError = "unknown error";

  for (const model of models) {
    for (let attempt = 0; attempt < 2; attempt++) {
      if (Date.now() - start > 22000) break;
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
          return { ok: true, text: data.candidates[0].content.parts[0].text };
        }
        lastError = (data.error && data.error.message) || ("status " + res.status);
        if (res.status === 400 || res.status === 401 || res.status === 403) {
          return { ok: false, status: 502, error: "Google said: " + lastError };
        }
        if (res.status === 503 || res.status === 429 || res.status === 500) {
          busy = true;
          await new Promise(function (r) { setTimeout(r, 700 * (attempt + 1)); });
          continue;
        }
        break;
      } catch (err) {
        lastError = err.message;
      }
    }
  }

  return {
    ok: false,
    status: busy ? 503 : 502,
    error: busy ? "The AI is busy right now. Please try again in a moment." : "Google said: " + lastError
  };
}
