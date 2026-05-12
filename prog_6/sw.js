self.addEventListener("install", (e) => {
  console.log("Service Worker Installed");

  e.waitUntil(
    caches.open("stock-cache").then((cache) => {
      return cache.addAll([
        "/",
        "./index.html",
        "./manifest.json",
        "./sw.js",
        "./data.json",
        "./assets/logo.png",
        "./assets/logo.ico",
      ]);
    }),
  );
});

self.addEventListener("activate", (e) => {
  console.log("Service Worker Activated");
});

self.addEventListener("fetch", (e) => {
  console.log("Fetching:", e.request.url);

  e.respondWith(
    caches.match(e.request).then((response) => {
      return response || fetch(e.request);
    }),
  );
});
