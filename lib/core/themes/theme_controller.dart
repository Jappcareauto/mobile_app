import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  void changeThemeMode(ThemeMode mode) {
    themeMode.value = mode;
  }

  bool get isDarkMode => themeMode.value == ThemeMode.dark;

  ThemeMode get currentTheme => themeMode.value;
}
