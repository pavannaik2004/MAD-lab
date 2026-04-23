const CACHE_NAME = "pwa-cache-v2";

self.addEventListener("load", (event) => {
  console.log("Service Worker loading.");
});

self.addEventListener("install", (event) => {
  console.log("Service Worker installing.");
});

self.addEventListener("activate", (event) => {
  console.log("Service Worker activating.");
});

self.addEventListener("fetch", (event) => {
  console.log("Fetching:", event.request.url);

  console.log("Fetch event handled.");
});
