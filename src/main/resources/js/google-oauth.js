const GOOGLE_CLIENT_ID =
  "242471320554-kfnpq2ji7t560h1jrsvbp0e99oqs6pch.apps.googleusercontent.com";

const GOOGLE_REDIRECT_URI =
  encodeURIComponent("http://localhost:8080/ASM_JAVA4/google-callback");

const GOOGLE_SCOPE =
  encodeURIComponent("openid email profile");

const GOOGLE_AUTH_URL =
  "https://accounts.google.com/o/oauth2/v2/auth"
  + "?client_id=" + GOOGLE_CLIENT_ID
  + "&redirect_uri=" + GOOGLE_REDIRECT_URI
  + "&response_type=code"
  + "&scope=" + GOOGLE_SCOPE
  + "&access_type=offline"
  + "&prompt=consent";

document.addEventListener("DOMContentLoaded", () => {
  const btn = document.getElementById("googleLoginBtn");
  if (btn) btn.href = GOOGLE_AUTH_URL;
});
