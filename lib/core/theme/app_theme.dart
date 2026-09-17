import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // ثيم الوضع الداكن
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkAppBg,
      primaryColor: AppColors.neonEmerald,
      cardColor: AppColors.darkCardBg,
      textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonEmerald,
        secondary: AppColors.warmAmber,
        surface: AppColors.darkCardBg,
        onSurface: AppColors.darkTextMain,
      ),
      dividerColor: AppColors.darkCardBorder,
    );
  }

  // ثيم الوضع الفاتح
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightAppBg,
      primaryColor: AppColors.neonEmerald,
      cardColor: AppColors.lightCardBg,
      textTheme: GoogleFonts.cairoTextTheme(ThemeData.light().textTheme),
      colorScheme: const ColorScheme.light(
        primary: AppColors.neonEmerald,
        secondary: AppColors.warmAmber,
        surface: AppColors.lightCardBg,
        onSurface: AppColors.lightTextMain,
      ),
      dividerColor: AppColors.lightCardBorder,
    );
  }
}
