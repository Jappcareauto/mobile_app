import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'local_storage_service.dart';

Locale languageNameToLocale(String languageName) {
  switch (languageName) {
    case 'Français':
      return const Locale('fr');
    case 'English':
    default:
      return const Locale('en');
  }
}

String localeToLanguageName(Locale locale) {
  switch (locale.languageCode) {
    case 'fr':
      return 'Français';
    case 'en':
    default:
      return 'English';
  }
}

class LocaleService {
  final LocalStorageService _storage;

  LocaleService(this._storage);

  Locale getSavedLocale() {
    final saved = _storage.read(AppConstants.languageKey) as String?;
    if (saved != null) {
      return languageNameToLocale(saved);
    }
    return const Locale('fr');
  }

  void changeLocale(String languageName) {
    _storage.write(AppConstants.languageKey, languageName);
    Get.updateLocale(languageNameToLocale(languageName));
  }
}
