import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.bgDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        secondary: AppColors.gold,
        surface: AppColors.primaryLight,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(color: AppColors.textPremium, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.outfit(color: AppColors.textPremium, fontWeight: FontWeight.bold),
        displaySmall: GoogleFonts.outfit(color: AppColors.textPremium, fontWeight: FontWeight.bold),
        headlineLarge: GoogleFonts.outfit(color: AppColors.textPremium, fontWeight: FontWeight.w600),
        headlineMedium: GoogleFonts.outfit(color: AppColors.textPremium, fontWeight: FontWeight.w600),
        headlineSmall: GoogleFonts.outfit(color: AppColors.textPremium, fontWeight: FontWeight.w600),
        titleLarge: GoogleFonts.outfit(color: AppColors.textPremium, fontWeight: FontWeight.w500),
        bodyLarge: GoogleFonts.inter(color: AppColors.textDim),
        bodyMedium: GoogleFonts.inter(color: AppColors.textDim),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.bgLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        secondary: AppColors.softGold,
        surface: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(
          color: AppColors.primaryDark,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
