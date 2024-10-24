import 'package:get/get.dart';
import 'package:jappcare/features/home/navigation/private/home_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/services/localServices/local_storage_service.dart';
import '../../../../../core/utils/app_constants.dart';

class SelectLanguageController extends GetxController {
  final AppNavigation _appNavigation;
  SelectLanguageController(this._appNavigation);

  String groupValue = 'English';
  String selectedLanguage = 'English';
  final _localService = Get.find<LocalStorageService>();
  final loading = false.obs;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void changeLanguage(String? language) {
    if (language == null) return;
    groupValue = language;
    selectedLanguage = language;
    _localService.write(AppConstants.languageKey, language);
    update();
    goToNextPage();
  }

  void goToNextPage() {
    _localService.write(AppConstants.languageKey, selectedLanguage);
    _appNavigation.toNamedAndReplaceAll(HomePrivateRoutes.onboarding);
  }
}
