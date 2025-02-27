import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/events/app_events_service.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/garage/application/usecases/get_garage_by_owner_id_command.dart';
import 'package:jappcare/features/garage/application/usecases/get_garage_by_owner_id_usecase.dart';
import 'package:jappcare/features/garage/application/usecases/get_vehicle_list_command.dart';
import 'package:jappcare/features/garage/application/usecases/get_vehicle_list_usecase.dart';
import 'package:jappcare/features/garage/domain/entities/get_garage_by_owner_id.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BookAppointmentController extends GetxController{

  final AppNavigation _appNavigation ;
  var selectedDate = DateTime.now().obs;
  var selectedYear = DateTime.now().year.obs; // Année actuelle
  var selectedMonth = DateTime.now().month.obs; // Mois actuel
  RxString selectedTime = "MORNING".obs;

  var selectedImages = <File>[].obs;
  final ImagePicker _picker = ImagePicker();
  final GetVehicleListUseCase _getVehicleListUseCase = Get.find();
  final LocalStorageService _localStorageService = Get.find();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final GetGarageByOwnerIdUseCase _getGarageByOwnerIdUseCase = Get.find();
  final loading = true.obs;
  final vehicleLoading = true.obs;
  final vehicleId = ''.obs ;
  final vehicleVin = ''.obs ;
  GetGarageByOwnerId? myGarage;
  final globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Vehicle> vehicleList = [];
  RxString selectedLocation = "GARAGE".obs;
  var images = [
    AppImages.shopCar,
    AppImages.carClean,
  ].obs;
  final PageController pageController = PageController(
    viewportFraction: 0.9,
  );
  final RxInt currentPage = 0.obs;
    BookAppointmentController(this._appNavigation);
  @override
  void onInit() {
    super.onInit();
    // Listener pour synchroniser la page actuelle

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageController.hasClients) {
        pageController.jumpToPage(0); // Forcer le positionnement à la page 0
      }
    });
    pageController.addListener(() {
      int newPage = pageController.page!.round();
      if (currentPage.value != newPage) {
        currentPage.value = newPage;
        print("newPage");

        print(currentPage.value);
      }
    });

  }

  @override
  void dispose() {
    // pageController.dispose();
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
    globalControllerWorkshop.addMultipleData({
      "currentPage": currentPage,
      "selectedDate":selectedDate.value,
      "selectedLocation" : selectedLocation.value,
      "noteController" :noteController.text,
      "vehiculeId": vehicleId.value ,
      "selectedTime":selectedTime.value
    });
    globalControllerWorkshop.addMultipleImages(selectedImages);

  }
  Future<void> selectImagesFromGallery() async {
    final List<XFile> pickedFiles = await _picker
        .pickMultiImage(); // Utilisation de pickMultiImage pour plusieurs images

    if (pickedFiles.isNotEmpty) {
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