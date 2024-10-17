import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../dependences/app_dependences.dart';
import 'app_navigation.dart';

class GetXNavigationImpl implements AppNavigation {
  final String notFoundPage;
  GetXNavigationImpl(this.notFoundPage);

  @override
  Future<void>? toNamed(String routeName, {dynamic arguments}) {
    try {
      return Get.toNamed(routeName, arguments: arguments);
    } catch (e) {
      return Get.toNamed(notFoundPage, arguments: arguments);
    }
  }

  @override
  Future<void>? to(Widget page, {dynamic arguments}) {
    try {
      return Get.to(page, arguments: arguments);
    } catch (e) {
      return Get.toNamed(notFoundPage, arguments: arguments);
    }
  }

  @override
  Future<void>? toNamedAndReplace(String routeName, {dynamic arguments}) {
    try {
      return Get.offNamed(routeName, arguments: arguments);
    } catch (e) {
      return Get.toNamed(notFoundPage, arguments: arguments);
    }
  }

  @override

  Future<void>? toNamedAndReplaceAll(String routeName, {dynamic arguments}) {
    try {
      Get.offAllNamed(routeName, arguments: arguments);
      return AppDependency.init();
    } catch (e) {
      return Get.toNamed(notFoundPage, arguments: arguments);
    }
  }

  @override
  void goBack<T>({T? result}) {
    try {
      Get.back(result: T);
    } catch (e) {
      Get.toNamed(notFoundPage);
    }
  }
}
