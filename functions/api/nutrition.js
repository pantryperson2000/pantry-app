// Cloudflare Pages Function: estimates the nutrition of one serving for each of several foods.
// The API key stays here on the server (set as GEMINI_API_KEY in Cloudflare).
function clean(t) {
  return String(t).replace(/[^\p{L}\p{N} '-]/gu, "").slice(0, 40).trim();
}

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

  const foods = Array.isArray(b.foods) ? b.foods.slice(0, 8).map(clean).filter(Boolean) : [];
  if (!foods.length) return json({ error: "Send at least one food" }, 400);

  const prompt =
    "Estimate the nutrition of ONE typical serving of each of these foods, in the same order: " + foods.join(", ") + ". " +
    "Reply ONLY with a JSON array with exactly " + foods.length + " objects, like " +
    '[{"name":"egg","serving":"1 large egg","calories":72,"protein":6,"carbs":0,"fat":5,"fiber":0,"sugar":0,"sodium":71}]. ' +
    "Use each food name exactly as given. Calories are kcal, protein/carbs/fat/fiber/sugar are grams, sodium is milligrams.";

  const requestBody = JSON.stringify({
    contents: [{ parts: [{ text: prompt }] }],
    generationConfig: { responseMimeType: "application/json" }
  });

  const out = await askGemini(key, requestBody);
  if (!out.ok) return json({ error: out.error }, out.status);
  try {
    const parsed = JSON.parse(out.text);
    if (!Array.isArray(parsed)) throw new Error("not a list");
    return json({ items: parsed });
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
            body: requestBody,
            signal: AbortSignal.timeout(12000)
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
        if (err && err.name === "TimeoutError") { busy = true; lastError = "timed out"; } else { lastError = err.message; }
      }
    }
  }

  return {
    ok: false,
    status: busy ? 503 : 502,
    error: busy ? "The AI is busy right now. Please try again in a moment." : "Google said: " + lastError
  };
}
