import 'package:flutter/material.dart';

class AppColors {
  // Aksen utama (coral) & variasinya
  static const primary = Color(0xFFFF6B6B);
  static const primaryLight = Color(0xFFFF9A8B);

  // Papan & teks
  static const background = Color(0xFFFBF3E4);
  static const surface = Colors.white;
  static const textDark = Color(0xFF2B2B2B);
  static const textGrey = Color(0xFF8A8A8A);
  static const border = Color(0xFFEAE0D0);
  static const field = Colors.white;

  // Warna sticky notes
  static const noteYellow = Color(0xFFFFE066);
  static const notePink = Color(0xFFFFB3D1);
  static const noteBlue = Color(0xFFA8D8FF);
  static const noteGreen = Color(0xFFB8E6B8);
  static const notePurple = Color(0xFFD6C2FF);
  static const noteOrange = Color(0xFFFFC08A);

  static const noteColors = [
    noteYellow,
    notePink,
    noteBlue,
    noteGreen,
    notePurple,
    noteOrange,
  ];

  /// Versi warna yang lebih gelap untuk ikon/aksen di atas kartu sticky.
  static Color darken(Color color, [double amount = 0.35]) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }
}

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      surface: AppColors.background,
    ),
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textDark,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: AppColors.textDark,
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.field,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      hintStyle: const TextStyle(color: AppColors.textGrey, fontSize: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(50),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.textDark,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
  );
}
