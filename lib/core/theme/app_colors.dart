import 'package:flutter/material.dart';

class AppColors {
  // Primary (Deep Navy)
  static const Color primaryDark = Color(0xFF0A192F);
  static const Color primaryLight = Color(0xFF172A45);
  
  // Secondary (Gold / Luxury Accent)
  static const Color secondary = Color(0xFF64FFDA); // Teal-ish from original premium themes
  static const Color gold = Color(0xFFFFD700);
  static const Color softGold = Color(0xFFC5A059);
  
  // Text
  static const Color textPremium = Color(0xFFCCD6F6);
  static const Color textDim = Color(0xFF8892B0);
  
  // Backgrounds
  static const Color bgDark = Color(0xFF0A192F);
  static const Color bgLight = Color(0xFFF8F9FA);
  static const Color cardBg = Color(0xFF172A45);
  
  // Gradients
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [primaryDark, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [gold, softGold, Color(0xFFFFE082)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
