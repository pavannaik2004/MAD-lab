if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker
      .register("./sw.js")
      .then((reg) => console.log("SW: Registered successfully!", reg.scope))
      .catch((err) => console.log("SW: Registration failed:", err));
  });
}

localStorage.setItem("username", "rvce");
localStorage.setItem("passme1", "rvce");

function verify() {
  let username = document.getElementById("username").value;
  let password = document.getElementById("password").value;
  let un = localStorage.getItem("username");
  let pas = localStorage.getItem("passme1");
  alert(username + " " + password + " " + un + " " + pas);
  if (un === username && pas === password) {
    alert("authentication done");
  } else {
    alert("authentication failure");
  }
}
