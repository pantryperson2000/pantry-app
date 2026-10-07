// Netlify function: creates recipe ideas with Google Gemini.
// Works two ways: from a list of pantry items, or from exactly two foods.
// The API key stays here on the server.
function clean(t) {
  return String(t).replace(/[^\p{L}\p{N} '-]/gu, "").slice(0, 40).trim();
}

exports.handler = async function (event) {
  if (event.httpMethod !== "POST") {
    return { statusCode: 405, body: JSON.stringify({ error: "Use POST" }) };
  }
  const key = process.env.GEMINI_API_KEY;
  if (!key) {
    return { statusCode: 500, body: JSON.stringify({ error: "Missing GEMINI_API_KEY in Netlify" }) };
  }

  let b;
  try {
    b = JSON.parse(event.body);
  } catch (err) {
    return { statusCode: 400, body: JSON.stringify({ error: "Bad request" }) };
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
    if (!name) {
      return { statusCode: 400, body: JSON.stringify({ error: "Missing recipe name" }) };
    }
    prompt = "Give clear, simple step-by-step instructions to make " + name +
      (ings.length ? " using: " + ings.join(", ") : "") + ". " +
      'Reply ONLY with JSON like {"time":"20 min","steps":["Step one.","Step two."]}. Use at most 8 steps.';
  } else if (Array.isArray(b.foods)) {
    const foods = b.foods.slice(0, 2).map(clean);
    if (foods.length !== 2 || !foods[0] || !foods[1]) {
      return { statusCode: 400, body: JSON.stringify({ error: "Enter two foods" }) };
    }
    prompt = "Give 4 different home-cooking recipes that use BOTH " + foods[0] + " and " + foods[1] + ". Make them " + levels[level] + ". ";
  } else if (Array.isArray(b.pantry) && b.pantry.length) {
    const items = b.pantry.slice(0, 40).map(function (i) {
      return clean(i.name) + " (" + (Number(i.days) || 0) + " days left)";
    }).filter(function (t) { return t.length > 12 || t.indexOf("(") > 0; });
    prompt =
      "Here is what I have in my pantry, with days until it expires: " + items.join(", ") + ". " +
      "Give 6 different recipes I can mostly make from these. Basic staples like salt, oil, and water can be assumed. " +
      "Prefer recipes that use the items expiring soonest. Make them " + levels[level] + ". ";
  } else {
    return { statusCode: 400, body: JSON.stringify({ error: "Nothing to make recipes from" }) };
  }

  if (!isDetail && exclude.length) prompt += "Do not repeat these recipes: " + exclude.join(", ") + ". ";
  if (!isDetail) prompt +=
    'Reply ONLY with a JSON array like [{"name":"Recipe name","level":"simple","time":"20 min","ingredients":["2 eggs","1 tomato"],"steps":["Step one.","Step two."]}]. ' +
    'The "level" must be simple, medium, or complex. Keep each recipe to at most 8 steps.';

  const requestBody = JSON.stringify({
    contents: [{ parts: [{ text: prompt }] }],
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
        const out = JSON.parse(data.candidates[0].content.parts[0].text);
        return {
          statusCode: 200,
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(isDetail ? out : { recipes: out })
        };
      }

      lastError = (data.error && data.error.message) || ("status " + res.status);
      if (res.status !== 503 && res.status !== 429 && res.status !== 500) break;
    } catch (err) {
      lastError = err.message;
    }
  }

  return { statusCode: 502, body: JSON.stringify({ error: "Google said: " + lastError }) };
};
