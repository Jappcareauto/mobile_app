import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/events/app_events_service.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
// import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/error/ui/commingSoon/comming_soon_screen.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/features/home/application/usecases/get_tips_list_usecase.dart';
import 'package:jappcare/features/home/domain/entities/get_tips_list.entity.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../widgets/tip_modal_bottom.dart';

class HomeController extends GetxController {
  final AppNavigation _appNavigation;
  HomeController(this._appNavigation);


  final GarageController garageController =
      GarageController(Get.find(), Get.find());

  // TIps loader
  final RxBool tipsLoading = true.obs;
  final getTipsListUseCase = GetTipsListUseCase(Get.find());
  RxList<TipEntity> tipsList = <TipEntity>[].obs;

  final PageController pageController = PageController(
    viewportFraction: 0.9,
  );
  final RxInt currentPage = 0.obs;
  List<String> notifications = [
    "Your repair from the Jappcare Autotech shop is ready, and available for pickup.",
    // "Votre commande a été expédiée.",
  ];

  // List<String> tips = [
  //   "Check your vehicle's tire pressure",
  //   "Rotate your tires regularly to ensure they wear evenly and last longer.",
  // ];

  Future<void> refreshData() async {
    print("debut du refresh");
    // Simule un délai de chargement (par exemple, une requête réseau)
    await Future.delayed(const Duration(seconds: 2));

    // Rafraîchir les données des widgets dynamiques
    // if (Get.isRegistered<FeatureWidgetInterface>(tag: 'ListVehicleWidget')) {
    //   Get.find<FeatureWidgetInterface>(tag: 'ListVehicleWidget').refreshData();
    // }

    // if (Get.isRegistered<FeatureWidgetInterface>(
    //     tag: 'RecentActivitiesWidget')) {
    //   Get.find<FeatureWidgetInterface>(tag: 'RecentActivitiesWidget')
    //       .refreshData();
    // }

    getAllTips();
    final lastUserId =
        Get.find<AppEventService>().getLastValue(AppConstants.userIdEvent);
    if (lastUserId != null) {
      garageController.fetchData(lastUserId);
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
    getAllTips();
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
  void openTipModal(TipEntity tip) {
    showModalBottomSheet(
        context: Get.context!,
        builder: (BuildContext context) {
          return TipModalBottomWidget(tip: tip);
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

  Future<void> getAllTips({String? status}) async {
    tipsLoading.value = true;
    final result = await getTipsListUseCase.call();
    result.fold(
      (e) {
        tipsLoading.value = false;
        if (Get.context != null) {
          Get.showCustomSnackBar(e.message);
        }
      },
      (response) {
        tipsLoading.value = false;
        tipsList.value = response;
      },
    );
  }

  void goToVehicleReport() =>
      _appNavigation.toNamed(AppRoutes.generateVehicleReport);

  void goToNotifications() => _appNavigation.toNamed(AppRoutes.notifications);
}
