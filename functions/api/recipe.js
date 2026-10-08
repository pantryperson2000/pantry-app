// Cloudflare Pages Function: creates recipe ideas and recipe steps with Google Gemini.
// Modes: whole pantry, exactly two foods, or steps for one recipe.
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

  const levels = {
    any: "a mix of simple, medium, and complex dishes",
    simple: "simple, quick dishes (under 30 minutes, few steps)",
    medium: "medium-effort dishes",
    complex: "complex, impressive dishes that take real cooking skill"
  };
  const level = levels[b.level] ? b.level : "any";
  const exclude = Array.isArray(b.exclude) ? b.exclude.slice(0, 30).map(clean).filter(Boolean) : [];

  let prompt;
  const isDetail = typeof b.recipe === "string";
  if (isDetail) {
    const name = clean(b.recipe);
    const ings = Array.isArray(b.ingredients) ? b.ingredients.slice(0, 20).map(clean).filter(Boolean) : [];
    if (!name) return json({ error: "Missing recipe name" }, 400);
    prompt = "Give clear, simple step-by-step instructions to make " + name +
      (ings.length ? " using: " + ings.join(", ") : "") + ". " +
      'Reply ONLY with JSON like {"time":"20 min","steps":["Step one.","Step two."]}. Use at most 8 steps.';
  } else if (Array.isArray(b.foods)) {
    const foods = b.foods.slice(0, 20).map(clean).filter(Boolean);
    if (!foods.length) return json({ error: "Pick at least one food" }, 400);
    prompt = "Give 4 different home-cooking recipes that use these foods: " + foods.join(", ") + ". " +
      "Each recipe should use as many of these foods as makes sense, and recipes that use all of them are best. " +
      "Other ingredients should be common kitchen staples. ";
  } else if (Array.isArray(b.pantry) && b.pantry.length) {
    const items = b.pantry.slice(0, 40).map(function (i) {
      return clean(i.name) + " (" + (Number(i.days) || 0) + " days left)";
    });
    prompt =
      "Here is what I have in my pantry, with days until it expires: " + items.join(", ") + ". " +
      "Give 6 different recipes I can mostly make from these. Basic staples like salt, oil, and water can be assumed. " +
      "Prefer recipes that use the items expiring soonest. Make them " + levels[level] + ". ";
  } else {
    return json({ error: "Nothing to make recipes from" }, 400);
  }

  if (!isDetail) {
    if (exclude.length) prompt += "Do not repeat these recipes: " + exclude.join(", ") + ". ";
    prompt +=
      'Reply ONLY with a JSON array like [{"name":"Recipe name","level":"simple","time":"20 min","ingredients":["2 eggs","1 tomato"],"steps":["Step one.","Step two."]}]. ' +
      'The "level" must be simple, medium, or complex. Keep each recipe to at most 8 steps.';
  }

  const requestBody = JSON.stringify({
    contents: [{ parts: [{ text: prompt }] }],
    generationConfig: { responseMimeType: "application/json" }
  });

  const out = await askGemini(key, requestBody);
  if (!out.ok) return json({ error: out.error }, out.status);
  try {
    const parsed = JSON.parse(out.text);
    return json(isDetail ? parsed : { recipes: parsed });
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
