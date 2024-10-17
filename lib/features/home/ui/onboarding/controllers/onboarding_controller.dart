import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/services/localServices/local_storage_service.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../navigation/private/home_private_routes.dart';

class OnboardingController extends GetxController {
  final AppNavigation _appNavigation;
  OnboardingController(this._appNavigation);

  final PageController pageController = PageController();
  final currentPage = 0.obs;
  final _localService = Get.find<LocalStorageService>();

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    if (_localService.read(AppConstants.firstOpen) != null) {
      _appNavigation.toNamed(HomePrivateRoutes.home);
    } else {
      _localService.write(AppConstants.firstOpen, true);
    }
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void onPageChange(int index) {
    currentPage.value = index;
    update();
  }
}
