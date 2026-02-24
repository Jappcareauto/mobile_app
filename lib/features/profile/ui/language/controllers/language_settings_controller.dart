import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/services/localServices/locale_service.dart';
import '../../../../../core/services/localServices/local_storage_service.dart';
import '../../../../../core/utils/app_constants.dart';

class LanguageSettingsController extends GetxController {
  final AppNavigation _appNavigation;
  LanguageSettingsController(this._appNavigation);

  String groupValue = 'Français';
  String selectedLanguage = 'Français';
  final _localService = Get.find<LocalStorageService>();

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() {
    final savedLanguage =
        _localService.read(AppConstants.languageKey) as String?;
    if (savedLanguage != null) {
      groupValue = savedLanguage;
      selectedLanguage = savedLanguage;
    } else {
      // Default to French — matches the app's default locale in main.dart
      groupValue = 'Français';
      selectedLanguage = 'Français';
    }
    update();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void changeLanguage(String? language) {
    if (language == null) return;
    groupValue = language;
    selectedLanguage = language;

    // Use LocaleService so persistence + locale update happen in one place
    Get.find<LocaleService>().changeLocale(language);

    update();
  }
}
