import 'package:flutter/material.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/app_dimensions.dart';

class AppThemeLight {
  static ThemeData get theme {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.orange,
        scaffoldBackgroundColor: AppColors.lightBackground,
        fontFamily: AppConstants.appFont,
        textTheme: _textThemeLight,
        colorScheme: const ColorScheme.light(
          primary: AppColors.orange,
          secondary: AppColors.purple,
          background: AppColors.lightBackground,
          surface: AppColors.lightSurface,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          textStyle: const TextStyle(color: AppColors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
        )));
  }

  static TextTheme get _textThemeLight {
    return const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
      displayMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
      displaySmall: TextStyle(fontSize: 28, fontWeight: FontWeight.normal),
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    );
  }
}
