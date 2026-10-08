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

  const out = await askGemini(key, requestBody);
  if (!out.ok) return json({ error: out.error }, out.status);
  try {
    let meal = JSON.parse(out.text);
    if (Array.isArray(meal)) meal = meal[0] || {};
    if (meal.error) return json({ error: String(meal.error) }, 422);
    return json({ meal: meal });
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
