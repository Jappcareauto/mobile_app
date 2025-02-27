import 'dart:async';

import 'package:get/get.dart';
import 'package:jappcare/features/error/ui/commingSoon/comming_soon_screen.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/services/localServices/local_storage_service.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../navigation/private/home_private_routes.dart';

class DashboardController extends GetxController {
  final AppNavigation _appNavigation;
  DashboardController(this._appNavigation);

  final _localService = Get.find<LocalStorageService>();
  final loading = false.obs;

  final selectedIndex = 0.obs;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    initialCheck();
  }

  void initialCheck() async {
    loading.value = true;
    if (_localService.read(AppConstants.tokenKey) == null) {
      await Future.delayed(const Duration(seconds: 1));
      await _appNavigation.toNamedAndReplaceAll(
          HomePrivateRoutes.selectLanguage);
      loading.value = false;
    } else {
      loading.value = false;
    }
  }

  void onItemTapped(int index) {
    if (index == 3) {

      Get.to(
            () => const CommingSoonScreen(),
        transition: Transition.rightToLeft,
      )?.then((_) {
        selectedIndex.value = 0;
      });
    } else {
      // Mets à jour l'index pour changer de page
      selectedIndex.value = index;
    }
  }


  void goBack() {
    _appNavigation.goBack();
  }
}
