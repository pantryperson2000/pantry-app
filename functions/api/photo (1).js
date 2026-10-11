// Cloudflare Pages Function: finds food photo candidates for a recipe, using Pixabay.
// The key stays here on the server (set as PIXABAY_API_KEY in Cloudflare).
// Pixabay asks for results to be cached for 24 hours, so every answer is cached.
// It returns several candidates so the app can give each recipe its OWN picture.
function clean(t) {
  return String(t || "").replace(/[^\p{L}\p{N} '-]/gu, " ").replace(/\s+/g, " ").slice(0, 60).trim();
}

const STOP = new Set(["a", "an", "and", "with", "on", "in", "of", "the", "for", "to"]);
const FILLER = new Set(["basic", "simple", "easy", "classic", "quick", "homemade", "best", "perfect", "delicious", "traditional", "fast", "favorite", "favourite"]);

// Search terms, most specific first: the dish name, then its last two words, then its last word.
function searchTerms(name) {
  const all = name.toLowerCase().split(" ").filter(Boolean);
  let w = all.filter(function (x) { return !STOP.has(x) && !FILLER.has(x); });
  if (!w.length) w = all;
  const out = [w.join(" ")];
  if (w.length > 2) out.push(w.slice(-2).join(" "));
  if (w.length > 1 && w[w.length - 1].length >= 4) out.push(w[w.length - 1]);
  return out.filter(function (t, i) { return t.length >= 3 && out.indexOf(t) === i; });
}

export async function onRequestGet(context) {
  const key = context.env.PIXABAY_API_KEY;
  const json = (obj, status, cacheControl) =>
    new Response(JSON.stringify(obj), {
      status: status || 200,
      headers: { "Content-Type": "application/json", "Cache-Control": cacheControl || "no-store" }
    });

  if (!key) return json({ error: "Missing PIXABAY_API_KEY in Cloudflare" }, 500);

  const url = new URL(context.request.url);
  const q = clean(url.searchParams.get("q"));
  if (!q) return json({ error: "Missing recipe name" }, 400);

  // Server-side cache (best effort: if it isn't available, everything still works)
  let cache = null, cacheKey = null;
  try {
    cache = caches.default;
    cacheKey = new Request(url.origin + "/api/photo-v2?q=" + encodeURIComponent(q.toLowerCase()));
    const hit = await cache.match(cacheKey);
    if (hit) return hit;
  } catch (err) { cache = null; }

  const cands = [];
  const seen = new Set();
  const terms = searchTerms(q);
  for (let i = 0; i < terms.length && cands.length < 4; i++) {
    let res;
    try {
      res = await fetch(
        "https://pixabay.com/api/?key=" + encodeURIComponent(key) +
          "&q=" + encodeURIComponent(terms[i]) +
          "&image_type=photo&category=food&safesearch=true&orientation=horizontal&per_page=8",
        { signal: AbortSignal.timeout(8000) }
      );
    } catch (err) {
      if (cands.length) break;
      return json({ error: "Photo service didn't answer. Try again in a moment." }, 502);
    }
    if (res.status === 429) {
      if (cands.length) break;
      return json({ error: "Photo service is busy right now." }, 503);
    }
    if (!res.ok) {
      if (cands.length) break;
      return json({ error: "Photo service error (" + res.status + ")" }, 502);
    }
    let data;
    try { data = await res.json(); } catch (err) { if (cands.length) break; return json({ error: "Couldn't read the photo answer." }, 502); }
    for (const h of data.hits || []) {
      if (!h.webformatURL || seen.has(h.id)) continue;
      seen.add(h.id);
      cands.push({ id: h.id, url: h.webformatURL, page: h.pageURL || "https://pixabay.com", user: h.user || "" });
      if (cands.length >= 6) break;
    }
  }

  // Found: keep 24h. Nothing found: remember for 6h so we don't keep searching.
  const response = cands.length
    ? json({ cands: cands }, 200, "public, max-age=86400")
    : json({ none: true }, 200, "public, max-age=21600");
  if (cache) {
    try { context.waitUntil(cache.put(cacheKey, response.clone())); } catch (err) {}
  }
  return response;
}
