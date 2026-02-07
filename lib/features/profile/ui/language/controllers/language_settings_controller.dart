import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/services/localServices/local_storage_service.dart';
import '../../../../../core/utils/app_constants.dart';

class LanguageSettingsController extends GetxController {
  final AppNavigation _appNavigation;
  LanguageSettingsController(this._appNavigation);

  String groupValue = 'English';
  String selectedLanguage = 'English';
  final _localService = Get.find<LocalStorageService>();

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() {
    final savedLanguage = _localService.read(AppConstants.languageKey);
    if (savedLanguage != null) {
      groupValue = savedLanguage;
      selectedLanguage = savedLanguage;
      update();
    }
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void changeLanguage(String? language) {
    if (language == null) return;
    groupValue = language;
    selectedLanguage = language;
    _localService.write(AppConstants.languageKey, language);

    // Update the app locale based on selection
    if (language == 'Français') {
      Get.updateLocale(const Locale('fr'));
    } else {
      Get.updateLocale(const Locale('en'));
    }

    update();
  }
}
