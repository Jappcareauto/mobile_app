import 'package:get/get.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/profile/navigation/private/profile_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class SettingsController extends GetxController {
  final AppNavigation _appNavigation;
  SettingsController(this._appNavigation);

  final _localService = Get.find<LocalStorageService>();

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void logout() async {
    Get.showLoader();
    await _localService.delete(AppConstants.tokenKey);
    await _localService.delete(AppConstants.refreshTokenKey);
    Get.closeLoader();
    await _appNavigation.toNamedAndReplaceAll(AppRoutes.home);
  }

  void goToNotifications() => _appNavigation.toNamed(AppRoutes.notifications);
  void goToTermsAndConditions() =>
      _appNavigation.toNamed(ProfilePrivateRoutes.termsAndConditions);
  void goToPrivacyPolicy() =>
      _appNavigation.toNamed(ProfilePrivateRoutes.privacyPolicy);
  void goToEditProfile() =>
      _appNavigation.toNamed(ProfilePrivateRoutes.editProfile);
  void goToHistory() => _appNavigation.toNamed(ProfilePrivateRoutes.history);
  void goToPayments() => _appNavigation.toNamed(ProfilePrivateRoutes.payments);
}
