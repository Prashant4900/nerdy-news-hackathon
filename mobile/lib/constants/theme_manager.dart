import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFDFDFD),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFFDFDFD),
        foregroundColor: const Color(0xFF121212),
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: const Color(0xFF121212),
          fontWeight: FontWeight.w600,
          fontSize: 24,
          fontFamily: GoogleFonts.robotoSlab().fontFamily,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFBDBDBD),
        thickness: 0.5,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF121212),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF121212),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: Colors.black,
      ),
      textTheme: textThemeManager(
        textTheme,
        color: Colors.black,
        lightColor: const Color(0xFF757575),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF121212),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Color(0xFFFDFDFD),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.white,
        contentTextStyle: TextStyle(
          color: AppColors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Color(0xFFFDFDFD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.pureBlack,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.robotoSlab().fontFamily,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.white,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.white,
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.white,
      ),
      textTheme: textThemeManager(
        textTheme,
        color: AppColors.white,
        lightColor: AppColors.grey,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.white,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.grey,
        thickness: 0.5,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.pureBlack,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.black,
        contentTextStyle: TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
      ),
    );
  }

  static InputDecorationTheme inputDecorationThemeData({
    Color? fillColor,
    Color? hintColor,
    Color? prefixIconColor,
    Color? iconColor,
  }) {
    return InputDecorationTheme(
      fillColor: fillColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      hintStyle: TextStyle(
        color: hintColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      prefixIconColor: prefixIconColor,
      iconColor: iconColor,
    );
  }

  static TextTheme textThemeManager(
    TextTheme textTheme, {
    Color? color,
    Color? lightColor,
  }) {
    return GoogleFonts.robotoSlabTextTheme(textTheme).copyWith(
      bodySmall: GoogleFonts.robotoSlab(
        textStyle: textTheme.bodySmall,
        color: lightColor,
      ),
      bodyMedium: GoogleFonts.robotoSlab(
        textStyle: textTheme.bodyMedium,
        color: lightColor,
      ),
      bodyLarge: GoogleFonts.robotoSlab(
        textStyle: textTheme.bodyLarge,
        color: color,
      ),
      headlineSmall: GoogleFonts.robotoSlab(
        textStyle: textTheme.headlineSmall,
        color: color,
      ),
      headlineMedium:
          GoogleFonts.robotoSlab(textStyle: textTheme.headlineMedium),
      headlineLarge: GoogleFonts.robotoSlab(textStyle: textTheme.headlineLarge),
      labelSmall: GoogleFonts.robotoSlab(
        textStyle: textTheme.labelSmall,
        color: color,
      ),
      labelMedium: GoogleFonts.robotoSlab(
        textStyle: textTheme.labelMedium,
        color: color,
      ),
      labelLarge: GoogleFonts.robotoSlab(
        textStyle: textTheme.labelLarge,
        color: color,
      ),
      titleSmall: GoogleFonts.robotoSlab(
        textStyle: textTheme.titleSmall,
        color: color,
      ),
      titleMedium: GoogleFonts.robotoSlab(
        textStyle: textTheme.titleMedium,
        color: color,
      ),
      titleLarge: GoogleFonts.robotoSlab(
        textStyle: textTheme.titleLarge,
        color: color,
      ),
      displaySmall: GoogleFonts.robotoSlab(
        textStyle: textTheme.displaySmall,
        color: color,
      ),
      displayMedium: GoogleFonts.robotoSlab(
        textStyle: textTheme.displayMedium,
        color: color,
      ),
      displayLarge: GoogleFonts.robotoSlab(
        textStyle: textTheme.displayLarge,
        color: color,
      ),
    );
  }
}
