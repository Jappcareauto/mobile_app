import 'package:get/get.dart';
import '../../../../../features/home/navigation/private/home_private_routes.dart';
import '../../../../navigation/app_navigation.dart';
import '../../../../services/localServices/local_storage_service.dart';
import '../../../../utils/app_constants.dart';

class SplashController extends GetxController {
  final AppNavigation _appNavigation;
  SplashController(this._appNavigation);

  final _localService = Get.find<LocalStorageService>();

  @override
  void onInit() {
    super.onInit();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 3));
    if (_localService.read(AppConstants.languageKey) != null) {
      _appNavigation.toNamed(_localService.read(AppConstants.firstOpen) != null
          ? HomePrivateRoutes.dashboard
          : HomePrivateRoutes.onboarding);
    }else{
      _appNavigation.toNamed(HomePrivateRoutes.selectLanguage);
    }
  }
}
