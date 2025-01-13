import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/features/services/navigation/private/services_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class GenerateVehiculeReportController extends GetxController {
  final AppNavigation _appNavigation;
  final GarageController garageController = Get.find();
  GenerateVehiculeReportController(this._appNavigation);
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;
  List<Vehicle> vehicleList = [];

  final List<Map<String, String>>  cars = [
    {
      "carName": "Porshe Taycan Turbo S",
      "carDetails": "2024, RWD",
      "imagePath": AppImages.carWhite,
    },
    {
      "carName": "Tesla Model S Plaid",
      "carDetails": "2023, AWD",
      "imagePath": AppImages.carWhite,
    },
    {
      "carName": "Audi e-Tron GT",
      "carDetails": "2022, AWD",
      "imagePath": AppImages.carWhite,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageController.hasClients) {
        pageController.jumpToPage(0); // Forcer le positionnement à la page 0
      }
    });
    pageController.addListener(() {
      int newPage = pageController.page!.round();
      if (currentPage.value != newPage) {
        currentPage.value = newPage;
      }
    });
  }


  // @override
  // void dispose() {
  //   super.dispose();
  //
  //   pageController.dispose();
  // }

  void goBack(){
    _appNavigation.goBack();
  }
  void goToAddVehicle(){
    _appNavigation.toNamed(ServicesPrivateRoutes.addVehicle);
  }
  void goToOderDetails(){
    _appNavigation.toNamed(ServicesPrivateRoutes.oderDetail);
  }

}
