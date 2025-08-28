import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/features/error/ui/commingSoon/comming_soon_screen.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../widgets/tip_modal_bottom.dart';

class HomeController extends GetxController {
  final AppNavigation _appNavigation;
  HomeController(this._appNavigation);
  final PageController pageController = PageController(
    viewportFraction: 0.9,
  );
  final RxInt currentPage = 0.obs;
  List<String> notifications = [
    "Your repair from the Jappcare Autotech shop is ready, and available for pickup.",
    // "Votre commande a été expédiée.",
  ];

  List<String> tips = [
    "Check your vehicle's tire pressure",
    "Rotate your tires regularly to ensure they wear evenly and last longer.",
  ];

  Future<void> refreshData() async {
    print("debut du refresh");
    // Simule un délai de chargement (par exemple, une requête réseau)
    await Future.delayed(const Duration(seconds: 2));

    // Rafraîchir les données des widgets dynamiques
    if (Get.isRegistered<FeatureWidgetInterface>(tag: 'ListVehicleWidget')) {
      Get.find<FeatureWidgetInterface>(tag: 'ListVehicleWidget').refreshData();
    }

    if (Get.isRegistered<FeatureWidgetInterface>(
        tag: 'RecentActivitiesWidget')) {
      Get.find<FeatureWidgetInterface>(tag: 'RecentActivitiesWidget')
          .refreshData();
    }
    print('fin du refresh');
  }

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    pageController.addListener(() {
      int newPage = pageController.page!.round();
      if (currentPage.value != newPage) {
        currentPage.value = newPage;
      }
    });
  }

  void navigateTCommingSoon() {
    Get.to(() => const CommingSoonScreen(), transition: Transition.leftToRight);
  }

  void navigateToWorkShopScreen() {
    Get.to(() => const CommingSoonScreen(), transition: Transition.leftToRight);
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

  void goToservices() {
    _appNavigation.toNamed(AppRoutes.services);
  }

  void goToEmergency() {
    _appNavigation.toNamed(AppRoutes.emergency);
  }

  void goToVehicleFinder() {
    _appNavigation.toNamed(AppRoutes.workshop);
  }

  void goToVehicleReport() =>
      _appNavigation.toNamed(AppRoutes.generateVehicleReport);

  void goToNotifications() => _appNavigation.toNamed(AppRoutes.notifications);
}
