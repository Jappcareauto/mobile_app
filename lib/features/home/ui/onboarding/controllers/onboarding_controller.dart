import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import '../../../../../core/navigation/app_navigation.dart';

class OnboardingController extends GetxController {
  final AppNavigation _appNavigation;
  OnboardingController(this._appNavigation);

  late PageController pageController;
  final currentPage = 0.obs;

  final _localStorageService = Get.find<LocalStorageService>();

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    if(_localStorageService.read(AppConstants.firstOpen) != null) {
      currentPage.value = 2;
      pageController = PageController(initialPage: currentPage.value);
    } else {
      currentPage.value = 0;
      pageController = PageController(initialPage: currentPage.value);
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
