const CACHE_NAME = "pwa-v1";
const assets = [
  "./",
  "./index.html",
  "./manifest.json",
  "./js/app.js",
  "./icons/rvce_logo.png",
  "./icons/rvce_logo1.png",
  "./icons/rvce_logo2.png",
];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(assets);
    }),
  );
});

self.addEventListener("activate", (event) => {
  console.log("inside the activate", event);
});

self.addEventListener("fetch", (event) => {
  event.respondWith(
    caches
      .match(event.request)
      .then((cached) => cached || fetch(event.request)),
  );
});
