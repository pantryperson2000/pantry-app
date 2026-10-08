// Cloudflare Pages Function: estimates the nutrition of a meal from a photo and/or a short description.
// The API key stays here on the server (GEMINI_API_KEY in Cloudflare).
export async function onRequestPost(context) {
  const key = context.env.GEMINI_API_KEY;
  const json = (obj, status) =>
    new Response(JSON.stringify(obj), { status: status || 200, headers: { "Content-Type": "application/json" } });

  if (!key) return json({ error: "Missing GEMINI_API_KEY in Cloudflare" }, 500);

  let b;
  try {
    b = await context.request.json();
  } catch (err) {
    return json({ error: "Bad request" }, 400);
  }

  const text = typeof b.text === "string" ? b.text.slice(0, 300).trim() : "";
  const hasImg = typeof b.image === "string" && b.image.length > 100;
  if (!hasImg && !text) return json({ error: "Send a photo or a description" }, 400);

  const prompt =
    "You estimate the nutrition of food. " +
    (hasImg ? "Look at the photo of a meal or snack. " : "") +
    (text ? "The person describes it as: " + text + ". " : "") +
    "Identify it, judge typical portion sizes, and estimate the total nutrition for everything shown or described. " +
    'Reply ONLY with JSON like {"name":"Scrambled eggs on toast","foods":["2 eggs","1 slice toast"],"calories":320,"protein":18,"carbs":22,"fat":16,"fiber":2,"sugar":3,"sodium":480}. ' +
    "Calories are kcal, protein/carbs/fat/fiber/sugar are grams, sodium is milligrams. " +
    'If there is no food, reply {"error":"No food found"}.';

  const parts = [{ text: prompt }];
  if (hasImg) parts.push({ inline_data: { mime_type: b.mimeType || "image/jpeg", data: b.image } });

  const requestBody = JSON.stringify({
    contents: [{ parts: parts }],
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
        let out = JSON.parse(data.candidates[0].content.parts[0].text);
        if (Array.isArray(out)) out = out[0] || {};
        if (out.error) return json({ error: String(out.error) }, 422);
        return json({ meal: out });
      }

      lastError = (data.error && data.error.message) || ("status " + res.status);
      if (res.status !== 503 && res.status !== 429 && res.status !== 500) break;
    } catch (err) {
      lastError = err.message;
    }
  }

  return json({ error: "Google said: " + lastError }, 502);
}
