import 'package:supabase_flutter/supabase_flutter.dart';String mapAuthError(dynamic error) {
  // 🟢 أهم سطر (حل مشكلتك)
  if (error is AuthWeakPasswordException) {
    return "Password is too weak (min 6 characters)";
  }

  String msg = "";
  String code = "";
  String errCode = "";

  if (error is AuthException) {
    msg = (error.message).toLowerCase();
    code = error.statusCode?.toString() ?? "";
    errCode = (error.code ?? "").toString().toLowerCase();
  } else {
    return "Something went wrong. Please try again";
  }

  // 🔐 LOGIN / SIGNUP
  if (msg.contains("invalid login credentials") ||
      errCode.contains("invalid_credentials")) {
    return "Incorrect email or password";
  }

  // 🆕 USER EXISTS
  if (msg.contains("user already registered")) {
    return "This account already exists";
  }

  // 📧 EMAIL VALIDATION
  if (msg.contains("unable to validate email address")) {
    return "Invalid email address";
  }

  if (msg.contains("email not confirmed")) {
    return "Please verify your email first";
  }

  // 👤 USER NOT FOUND
  if (msg.contains("user not found")) {
    return "No account found with this email";
  }

  // 🚫 RATE LIMIT
  if (code == "429" ||
      msg.contains("rate limit") ||
      errCode.contains("over_email_send_rate_limit")) {
    return "Too many attempts. Please wait 30s and try again";
  }

  // 🌐 NETWORK
  if (msg.contains("socket") ||
      msg.contains("network") ||
      msg.contains("failed host lookup") ||
      code == "0") {
    return "No internet connection";
  }

  // 🔥 SERVER ERROR
  if (code.startsWith("5")) {
    return "Server error. Please try again later";
  }

  // 🔒 ANONYMOUS
  if (msg.contains("anonymous sign-ins are disabled")) {
    return "Guest login is not available";
  }

  // 🔁 RESET PASSWORD
  if (msg.contains("email rate limit")) {
    return "Too many reset requests. Try again later";
  }

  return "Authentication failed. Please try again later";
}