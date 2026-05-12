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

// Activate → Delete old caches
self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cache) => {
          if (cache !== CACHE_NAME) {
            return caches.delete(cache);
          }
        }),
      );
    }),
  );
});

//  Serve from cache first
self.addEventListener("fetch", (event) => {
  event.respondWith(
    caches.match(event.request).then((cachedResponse) => {
      // Fetch latest response from network
      const fetchPromise = fetch(event.request).then((networkResponse) => {
        // Update cache
        caches.open(CACHE_NAME).then((cache) => {
          cache.put(event.request, networkResponse.clone());
        });

        return networkResponse;
      });

      // Return cache first, otherwise network
      return cachedResponse || fetchPromise;
      //return fetchPromise;
    }),
  );
});
