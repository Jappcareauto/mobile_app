import 'package:get/get.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/features/home/navigation/private/home_private_routes.dart';
import '../../../../navigation/app_navigation.dart';

class SplashController extends GetxController {
  final AppNavigation _appNavigation;
  SplashController(this._appNavigation);

  @override
  void onInit() {
    super.onInit();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    // Minimum splash display time so the brand animation is visible.
    await Future.delayed(const Duration(seconds: 3));

    // NOTE: Location disclosure is intentionally NOT shown here.
    // The correct flow is: Splash → Language Selection → Location Disclosure.
    // The disclosure is triggered from DashboardController AFTER the user
    // has selected a language and logged in.

    _appNavigation.toNamedAndReplaceAll(_nextRoute());
  }

  String _nextRoute() {
    final localStorageService = Get.find<LocalStorageService>();
    final savedLanguage =
        localStorageService.read(AppConstants.languageKey) as String?;

    if (savedLanguage == null || savedLanguage.isEmpty) {
      return HomePrivateRoutes.selectLanguage;
    }
    return AppRoutes.home;
  }
}
