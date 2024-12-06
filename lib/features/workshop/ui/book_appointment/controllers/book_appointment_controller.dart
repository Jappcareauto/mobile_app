import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';

class BookAppointmentController extends GetxController{
  final AppNavigation _appNavigation ;
  var selectedDate = DateTime.now().obs;
  var selectedYear = DateTime.now().year.obs; // Année actuelle
  var selectedMonth = DateTime.now().month.obs; // Mois actuel
  RxString selectedTime = "".obs;
  RxString selectedLocation = "".obs;
  var images = [
    AppImages.shopCar,
    AppImages.carClean,


  ].obs;
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;
    BookAppointmentController(this._appNavigation);
  final cars = [
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
      "carDetails": "2023, AWD",
      "imagePath": AppImages.carWhite,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    // Listener pour synchroniser la page actuelle
    pageController.addListener(() {
      int newPage = pageController.page!.round();
      if (currentPage.value != newPage) {
        currentPage.value = newPage;
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }


  void selectDate(DateTime date) {
    selectedDate.value = date;
  }
  void selectMonth(int month) {
    selectedMonth.value = month; // Mise à jour du mois sélectionné
  }
  void selectTime(String time) {
    selectedTime.value = time;
  }

  void selectLocation(String location) {
    selectedLocation.value = location;
  }
  void gotToConfirmAppointment () {
    _appNavigation.toNamed(WorkshopPrivateRoutes.confirmappointment);
  }
}