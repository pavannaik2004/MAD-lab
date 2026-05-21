// ===============================
// Shared helpers
// ===============================

const statusBox = document.getElementById("status");

function setStatus(message) {
  statusBox.textContent = message;
}

function isNotificationSupported() {
  return "Notification" in window;
}

async function requestNotificationPermission() {
  if (!isNotificationSupported()) {
    setStatus("This browser does not support notifications.");
    return "unsupported";
  }

  return Notification.requestPermission();
}

function showBasicNotification(title, options = {}) {
  new Notification(title, options);
}

// ===============================
// 1. Simple notification demo
// ===============================

const notifyBtn = document.getElementById("notifyBtn");

notifyBtn.addEventListener("click", async () => {
  const permission = await requestNotificationPermission();

  if (permission === "granted") {
    showBasicNotification("Hello!", {
      body: "This is my first notification.",
    });
    setStatus("Simple notification shown.");
  } else if (permission === "denied") {
    alert("Notification permission denied");
    setStatus("Permission denied for simple notification.");
  }
});

// ===============================
// 2. Request permission demo
// ===============================

const permissionBtn = document.getElementById("permissionBtn");

permissionBtn.addEventListener("click", async () => {
  // Log the current state before asking.
  console.log("Before request:", Notification.permission);

  const permission = await requestNotificationPermission();

  // Log the final permission result after the user responds.
  console.log("After request:", permission);

  if (permission === "granted") {
    alert("Permission Granted");
    setStatus("Permission granted.");
  } else if (permission === "denied") {
    alert("Permission Denied");
    setStatus("Permission denied.");
  } else if (permission === "default") {
    alert("Permission Closed");
    setStatus("Permission dialog closed without a choice.");
  }
});

// ===============================
// 3. Request permission and notify demo
// ===============================

const requestNotifyBtn = document.getElementById("requestNotifyBtn");

requestNotifyBtn.addEventListener("click", async () => {
  const permission = await requestNotificationPermission();

  if (permission === "granted") {
    showBasicNotification("Web Notification", {
      body: "Permission granted and notification sent.",
    });
    setStatus("Requested permission and displayed a notification.");
  } else if (permission === "denied") {
    setStatus("Permission denied, so no notification was shown.");
  }
});

// ===============================
// 4. Tagged notification demo
// ===============================

const tagBtn = document.getElementById("tagBtn");

tagBtn.addEventListener("click", async () => {
  const permission = await requestNotificationPermission();

  if (permission === "granted") {
    // First notification with a tag.
    showBasicNotification("Order Status", {
      body: "Your order has been shipped.",
      tag: "order-status",
      icon: "https://cdn-icons-png.flaticon.com/512/1046/1046784.png",
    });

    // Second notification after 3 seconds using the same tag.
    // The browser replaces the earlier notification instead of stacking a new one.
    setTimeout(() => {
      showBasicNotification("Order Status", {
        body: "Your order has been delivered.",
        tag: "order-status",
        icon: "https://cdn-icons-png.flaticon.com/512/1046/1046784.png",
      });
      setStatus("Tagged notification updated after 3 seconds.");
    }, 3000);

    setStatus("Tagged notification shown.");
  } else if (permission === "denied") {
    alert("Permission Denied");
    setStatus("Permission denied for tagged notifications.");
  }
});

// ===============================
// 5. Service worker notification demo
// ===============================

const swBtn = document.getElementById("swBtn");

if ("serviceWorker" in navigator) {
  navigator.serviceWorker
    .register("sw.js")
    .then(() => setStatus("Service worker registered."))
    .catch((error) => {
      console.log("SW Error:", error);
      setStatus("Service worker registration failed.");
    });
}

swBtn.addEventListener("click", async () => {
  const permission = await requestNotificationPermission();

  if (permission === "granted") {
    const registration = await navigator.serviceWorker.ready;

    // Show the first notification through the service worker.
    registration.showNotification("Order Update", {
      body: "Your order is being processed",
      tag: "order-status",
      icon: "https://cdn-icons-png.flaticon.com/512/1046/1046784.png",
    });

    // Show another notification with the same tag after 3 seconds.
    setTimeout(() => {
      registration.showNotification("Order Update", {
        body: "Your order has been shipped",
        tag: "order-status",
        icon: "https://cdn-icons-png.flaticon.com/512/1046/1046784.png",
      });
      setStatus("Service worker notification updated after 3 seconds.");
    }, 3000);

    setStatus("Service worker notification shown.");
  } else {
    alert("Permission not granted");
    setStatus("Permission not granted for service worker notifications.");
  }
});
