import 'package:get/get.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
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
}
