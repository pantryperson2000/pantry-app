// Cloudflare Pages Function: finds one food photo for a recipe, using Pixabay.
// The key stays here on the server (set as PIXABAY_API_KEY in Cloudflare).
// Pixabay asks for results to be cached for 24 hours, so every answer is cached.
function clean(t) {
  return String(t || "").replace(/[^\p{L}\p{N} '-]/gu, " ").replace(/\s+/g, " ").slice(0, 60).trim();
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
  const alt = clean(url.searchParams.get("alt"));
  if (!q) return json({ error: "Missing recipe name" }, 400);

  // Server-side cache (best effort: if it isn't available, everything still works)
  let cache = null, cacheKey = null;
  try {
    cache = caches.default;
    cacheKey = new Request(url.origin + "/api/photo?q=" + encodeURIComponent(q.toLowerCase()) + "&alt=" + encodeURIComponent(alt.toLowerCase()));
    const hit = await cache.match(cacheKey);
    if (hit) return hit;
  } catch (err) { cache = null; }

  const terms = [q];
  if (alt && alt.toLowerCase() !== q.toLowerCase()) terms.push(alt);

  let found = null;
  for (const term of terms) {
    let res;
    try {
      res = await fetch(
        "https://pixabay.com/api/?key=" + encodeURIComponent(key) +
          "&q=" + encodeURIComponent(term) +
          "&image_type=photo&category=food&safesearch=true&orientation=horizontal&per_page=5",
        { signal: AbortSignal.timeout(8000) }
      );
    } catch (err) {
      return json({ error: "Photo service didn't answer. Try again in a moment." }, 502);
    }
    if (res.status === 429) return json({ error: "Photo service is busy right now." }, 503);
    if (!res.ok) return json({ error: "Photo service error (" + res.status + ")" }, 502);
    let data;
    try { data = await res.json(); } catch (err) { return json({ error: "Couldn't read the photo answer." }, 502); }
    const hit = (data.hits || []).find(function (h) { return h.webformatURL; });
    if (hit) { found = { url: hit.webformatURL, page: hit.pageURL || "https://pixabay.com", user: hit.user || "" }; break; }
  }

  // Found: keep 24h. Nothing found: remember for 6h so we don't keep searching.
  const response = found
    ? json(found, 200, "public, max-age=86400")
    : json({ none: true }, 200, "public, max-age=21600");
  if (cache) {
    try { context.waitUntil(cache.put(cacheKey, response.clone())); } catch (err) {}
  }
  return response;
}
