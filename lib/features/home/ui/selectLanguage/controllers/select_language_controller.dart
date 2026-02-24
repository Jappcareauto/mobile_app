import 'package:get/get.dart';
import 'package:jappcare/features/home/navigation/private/home_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/services/localServices/locale_service.dart';
import '../../../../../core/services/localServices/local_storage_service.dart';
import '../../../../../core/utils/app_constants.dart';

class SelectLanguageController extends GetxController {
  final AppNavigation _appNavigation;
  SelectLanguageController(this._appNavigation);

  String groupValue = 'Français';
  String selectedLanguage = 'Français';
  final _localService = Get.find<LocalStorageService>();
  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Pre-select saved language; default to Français if none saved (matches app default)
    final saved = _localService.read(AppConstants.languageKey) as String?;
    groupValue = saved ?? 'Français';
    selectedLanguage = saved ?? 'Français';
    update();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void changeLanguage(String? language) {
    if (language == null) return;
    groupValue = language;
    selectedLanguage = language;
    // Persist and apply locale immediately
    final localeService = Get.find<LocaleService>();
    localeService.changeLocale(language);
    update();
    goToNextPage();
  }

  void goToNextPage() {
    _appNavigation.toNamedAndReplaceAll(HomePrivateRoutes.onboarding);
  }
}
