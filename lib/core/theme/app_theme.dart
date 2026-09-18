import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // ثيم الوضع الداكن (Cyber Dark)
  static ThemeData get darkTheme {
    final baseDark = ThemeData.dark();
    return baseDark.copyWith(
      scaffoldBackgroundColor: AppColors.darkAppBg,
      primaryColor: AppColors.neonEmerald,
      cardColor: AppColors.darkCardBg,
      // تطبيق خط زين على نصوص التطبيق بالكامل
      textTheme: GoogleFonts.zainTextTheme(baseDark.textTheme),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonEmerald,
        secondary: AppColors.warmAmber,
        surface: AppColors.darkCardBg,
        onSurface: AppColors.darkTextMain,
      ),
      dividerColor: AppColors.darkCardBorder,
    );
  }

  // ثيم الوضع الفاتح (Clean Light)
  static ThemeData get lightTheme {
    final baseLight = ThemeData.light();
    return baseLight.copyWith(
      scaffoldBackgroundColor: AppColors.lightAppBg,
      primaryColor: AppColors.neonEmerald,
      cardColor: AppColors.lightCardBg,
      // تطبيق خط زين على نصوص التطبيق بالكامل
      textTheme: GoogleFonts.zainTextTheme(baseLight.textTheme),
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
