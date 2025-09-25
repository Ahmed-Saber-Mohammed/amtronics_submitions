import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF0052CC); // Professional corporate blue
  static const Color secondaryBlue = Color(0xFF2684FF); // Lighter accent blue
  static const Color neutralGray = Color(0xFF42526E); // Professional text gray
  static const Color lightGray = Color(0xFFF4F5F7); // Subtle background
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color darkText = Color(0xFF172B4D); // High contrast text

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primaryBlue,
        secondary: secondaryBlue,
        surface: pureWhite,
        surfaceContainer: lightGray,
        onSurface: darkText,
        onPrimary: pureWhite,
        outline: Color(0xFFDFE1E6),
      ),
      textTheme: _textTheme.apply(
        bodyColor: darkText,
        displayColor: darkText,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: pureWhite,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          elevation: 2,
          shadowColor: primaryBlue.withOpacity(0.3),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlue,
          side: const BorderSide(color: primaryBlue, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme => lightTheme;

  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
      height: 1.1,
    ),
    displayMedium: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
      height: 1.2,
    ),
    headlineLarge: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.25,
      height: 1.3,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: 1.6,
      letterSpacing: 0.15,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: 0.25,
    ),
  );
}
