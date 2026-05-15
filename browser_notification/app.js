const permissionBtn = document.getElementById("permissionBtn");

permissionBtn.addEventListener("click", async () => {
  // Current permission before request
  console.log(Notification.permission);

  const permission = await Notification.requestPermission();

  // Permission after user action
  console.log(permission);

  if (permission === "granted") {
    alert("Permission Granted");
  } else if (permission === "denied") {
    alert("Permission Denied");
  } else {
    alert("Permission Closed");
  }
});
