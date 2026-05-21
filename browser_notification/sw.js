// Service worker lifecycle events.
self.addEventListener("install", () => {
  console.log("Service Worker Installed");
});

self.addEventListener("activate", () => {
  console.log("Service Worker Activated");
});

// Push event: this runs when a push message is received.
self.addEventListener("push", (event) => {
  const data = event.data ? event.data.text() : "Default message";

  event.waitUntil(
    self.registration.showNotification("Push Notification", {
      body: data,
      tag: "push-tag",
    }),
  );
});

// Notification click event: close the notification and open a page.
self.addEventListener("notificationclick", (event) => {
  event.notification.close();

  event.waitUntil(clients.openWindow("https://developer.mozilla.org"));
});
