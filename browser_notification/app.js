const notifyBtn = document.getElementById("notifyBtn");

notifyBtn.addEventListener("click", async () => {
  // Ask permission

  const permission = await Notification.requestPermission();

  // If allowed

  if (permission === "granted") {
    new Notification("Hello!", {
      body: "This is my first notification.",
      //   icon: "https://cdn-icons-png.flaticon.com/512/1827/1827392.png"
    });
  } else {
    alert("Notification permission denied");
  }
});
