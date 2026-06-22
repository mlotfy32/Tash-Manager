import 'package:flutter/material.dart';

class AppTheme {
  // =========================
  // 🎨 Light Mode Colors
  // =========================

  static const Color scaffoldBackgroundLight = Color(0xFFF8FAFC);
  // static const Color lightCard = Color(0xFFFFFFFF);
  // static const Color splashLight = Color(0xffE2E8F0);

  // =========================
  // 🌙 Dark Mode Colors
  // =========================

  static const Color scaffoldBackgroundDark = Color(0xFF121313);
  // static const Color dark = Colors.black;
  // static const Color darkCard = Color(0xFF1E293B);
  // static const Color splashDark = Color(0xff11D473);
  // static const Color subTitleTextDark = Color(0xff94A3B8);

  // =========================
  // ☀️ Light Theme
  // =========================

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: scaffoldBackgroundLight,
    cardColor: Color(0xFFF5F3F3),
    primaryColor: Colors.black
  );

  // =========================
  // 🌙 Dark Theme
  // =========================

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    hoverColor: Colors.transparent,
    scaffoldBackgroundColor: scaffoldBackgroundDark,
    cardColor: Color(0xFF2A2A2B),
    primaryColor: Colors.white

  );
}
