import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../widgets/tip_modal_bottom.dart';

class HomeController extends GetxController {
  final AppNavigation _appNavigation;
  HomeController(this._appNavigation);
  List<String> notifications = [
    "Your repair from the Jappcare Autotech shop is ready, and available for pickup.",
    "Votre commande a été expédiée.",

  ];
  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  //show modal bottom
  void openTipModal() {
    showModalBottomSheet(
        context: Get.context!,
        builder: (BuildContext context) {
          return const TipModalBottomWidget();
        });
  }
void goToservices(){
  _appNavigation.toNamed(AppRoutes.services);
}
  void goToVehicleReport() =>
      _appNavigation.toNamed(AppRoutes.generateVehicleReport);

  void goToNotifications() => _appNavigation.toNamed(AppRoutes.notifications);
}
