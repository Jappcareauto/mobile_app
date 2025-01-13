import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/events/app_events_service.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/services/networkServices/dio_network_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/garage/application/usecases/get_garage_by_owner_id_command.dart';
import 'package:jappcare/features/garage/application/usecases/get_garage_by_owner_id_usecase.dart';
import 'package:jappcare/features/garage/application/usecases/get_vehicle_list_command.dart';
import 'package:jappcare/features/garage/application/usecases/get_vehicle_list_usecase.dart';
import 'package:jappcare/features/garage/domain/entities/get_garage_by_owner_id.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BookAppointmentController extends GetxController{

  final AppNavigation _appNavigation ;
  var selectedDate = DateTime.now().obs;
  var selectedYear = DateTime.now().year.obs; // Année actuelle
  var selectedMonth = DateTime.now().month.obs; // Mois actuel
  RxString selectedTime = "Morning".obs;
  var selectedImages = <File>[].obs;
  final ImagePicker _picker = ImagePicker();
  final GetVehicleListUseCase _getVehicleListUseCase = Get.find();
  final LocalStorageService _localStorageService = Get.find();

  final GetGarageByOwnerIdUseCase _getGarageByOwnerIdUseCase = Get.find();
  final loading = true.obs;
  final vehicleLoading = true.obs;

  GetGarageByOwnerId? myGarage;

  List<Vehicle> vehicleList = [];
  RxString selectedLocation = "At the Shop".obs;
  var images = [
    AppImages.shopCar,
    AppImages.carClean,


  ].obs;
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;
    BookAppointmentController(this._appNavigation);
  final cars = [
    {
      "name": "Porshe Taycan Turbo S",
      "vin": "2024, RWD",
      "imageUrl": AppImages.carWhite,
    },
    {
      "name": "Tesla Model S Plaid",
      "vin": "2023, AWD",
      "imageUrl": AppImages.carWhite,
    },
    {
      "name": "Audi e-Tron GT",
      "vin": "2023, AWD",
      "imageUrl": AppImages.carWhite,
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
    getGarageByOwnerId(_localStorageService.read(AppConstants.userId));
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
  Future<void> selectImagesFromGallery() async {
    final List<XFile>? pickedFiles = await _picker
        .pickMultiImage(); // Utilisation de pickMultiImage pour plusieurs images

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      // Si des images sont sélectionnées, convertir chaque image en File et les ajouter à une liste
      selectedImages.value =
          pickedFiles.map((file) => File(file.path)).toList();
    } else {
      print('Aucune image sélectionnée.');
    }
  }
  Future<void> getGarageByOwnerId(String userId) async {

    loading.value = true;
    final result = await _getGarageByOwnerIdUseCase
        .call(GetGarageByOwnerIdCommand(userId: userId));
    result.fold(
          (e) {
        loading.value = false;
        Get.showCustomSnackBar(e.message);
      },
          (success) {
        myGarage = success;
        getVehicleList(myGarage!.id);
        Get.find<AppEventService>()
            .emit<String>(AppConstants.garageIdEvent, myGarage!.id);
        update();
        loading.value = false;
      },
    );
  }
  Future<void> getVehicleList(String garageId) async {
    vehicleLoading.value = true;
    final result = await _getVehicleListUseCase
        .call(GetVehicleListCommand(garageId: garageId));
    result.fold(
          (e) {
        vehicleLoading.value = false;
        Get.showCustomSnackBar(e.message);
      },
          (response) {
        vehicleList = response;
        print("vehicleList.toList()");

        print(response);
        update();
        vehicleLoading.value = false;
      },
    );
  }
}