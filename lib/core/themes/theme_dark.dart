import 'package:flutter/material.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_constants.dart';

class AppThemeDark {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.orange,
      scaffoldBackgroundColor: AppColors.darkBackground,
      fontFamily: AppConstants.appFont,
      textTheme: _textThemeDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.orange,
        secondary: AppColors.purple,
        background: AppColors.darkBackground,
        surface: AppColors.darkSurface,
      ),
      // Vous pouvez configurer d'autres propriétés ici.
    );
  }

  static TextTheme get _textThemeDark {
    return const TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.normal),
      displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.normal),
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.normal),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.normal),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    );
  }
}
