import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;

  void changeThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    Get.changeThemeMode(mode); // Apply the theme change
  }

  bool get isDarkMode => _themeMode.value == ThemeMode.dark;

  ThemeMode get currentTheme => _themeMode.value;
}
