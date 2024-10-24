import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';

class OnboardingController extends GetxController {
  final AppNavigation _appNavigation;
  OnboardingController(this._appNavigation);

  final PageController pageController = PageController();
  final currentPage = 0.obs;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void onPageChange(int index) {
    currentPage.value = index;
    update();
  }
}
