import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:jappcare/core/events/app_events_service.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
// import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
// import 'package:jappcare/features/garage/application/usecases/get_garage_by_owner_id_command.dart';
// import 'package:jappcare/features/garage/application/usecases/get_garage_by_owner_id_usecase.dart';
// import 'package:jappcare/features/garage/application/usecases/get_vehicle_list_command.dart';
// import 'package:jappcare/features/garage/application/usecases/get_vehicle_list_usecase.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/features/workshop/domain/entities/service_center_service.entity.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:jappcare/features/workshop/application/usecases/get_place_autocomplete_usecase.dart';
import 'package:jappcare/features/workshop/application/usecases/get_place_details_usecase.dart';
import 'package:jappcare/features/workshop/domain/entities/place_prediction.dart';
import 'package:jappcare/features/workshop/domain/entities/place_details.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BookAppointmentController extends GetxController {
  final AppNavigation _appNavigation;
  final garageController = Get.find<GarageController>();

  var selectedDate = DateTime.now().obs;
  var selectedYear = DateTime.now().year.obs; // Année actuelle
  var selectedMonth = DateTime.now().month.obs; // Mois actuel
  RxString selectedTime = "MORNING".obs;

  var selectedImages = <File>[].obs;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  // final GetGarageByOwnerIdUseCase _getGarageByOwnerIdUseCase = Get.find();
  // final GetVehicleListUseCase _getVehicleListUseCase = Get.find();
  final GetPlaceDetailsUseCase _getPlaceDetailsUseCase = Get.find();
  final GetPlaceAutocompleteUsecase _getPlaceAutocompleteUseCase = Get.find();

  final loading = true.obs;
  final vehicleLoading = true.obs;

  // Selected service observables
  final RxList<ServiceCenterServiceEntity> serviceCenterServices =
      <ServiceCenterServiceEntity>[].obs;
  final RxList<Vehicle> vehicles = <Vehicle>[].obs;
  final selectedServiceId = ''.obs;
  final selectedServiceName = ''.obs;
  final RxInt selectedServicePrice = 0.obs;
  final selectedServiceIndex = 0.obs;

  // Observables to manage the vehicles
  final vehicleId = ''.obs;
  final vehicleVin = ''.obs;
  // List<Vehicle> vehicleList = [];

  final globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // The location state of the form
  RxString selectedLocation = "SERVICE_CENTER".obs;
  RxString placeInput = "".obs;
  RxList<PlacePrediction> placePredictions = <PlacePrediction>[].obs;
  late final PlaceDetails placeDetails;
  // End on the location state of the form

  var images = [
    AppImages.shopCar,
    AppImages.carClean,
  ].obs;

  // Observers to manage the selection of the vehicle for the appointment
  final PageController pageController = PageController(
    viewportFraction: 0.9,
  );
  final RxInt currentPage = 0.obs;

  BookAppointmentController(this._appNavigation);

  @override
  void onInit() {
    super.onInit();
    // Listener pour synchroniser la page actuelle
    serviceCenterServices.value =
        globalControllerWorkshop.workshopData['serviceCenterServices']
            as List<ServiceCenterServiceEntity>;

    if (globalControllerWorkshop.workshopData['serviceCenterId'] != null) {
      print(garageController.vehicleList);
      vehicles.value = garageController.vehicleList
          .where((e) =>
              e.serviceCenterId ==
              globalControllerWorkshop.workshopData['serviceCenterId'])
          .toList();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (serviceCenterServices.isNotEmpty) {
        selectedServiceId.value = serviceCenterServices[0].service.id;
        selectedServiceName.value = serviceCenterServices[0].service.title;
        if (serviceCenterServices[0].price != null) {
          selectedServicePrice.value = serviceCenterServices[0].price!.round();
        }
        // selectedServiceIndex.value = 0;
      }

      if (pageController.hasClients) {
        pageController.jumpToPage(0); // Forcer le positionnement à la page 0
      }
    });

    debounce(placeInput, (value) {
      if (value.isNotEmpty && value == locationController.text) {
        getPlaceAutocomplete(value);
      } else {
        placePredictions.value = [];
      }
    }, time: const Duration(milliseconds: 500));

    // Listen for VIN input changes
    locationController.addListener(() {
      print("onChanGE");
      placeInput.value = locationController.text;
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

  void gotToConfirmAppointment() {
    _appNavigation.toNamed(WorkshopPrivateRoutes.confirmappointment);
    globalControllerWorkshop.addMultipleData({
      "selectedDate": selectedDate.value,
      "selectedLocation": selectedLocation.value,
      "serviceName": selectedServiceName.value,
      "servicePrice": selectedServicePrice.value,
      "serviceId": selectedServiceId.value,
      "noteController": noteController.text,
      "vehicle": vehicles[currentPage.value],
      "selectedTime": selectedTime.value
    });
    globalControllerWorkshop.setImages(selectedImages);
  }

  void removeImageFromGallery(File index) {
    if (selectedImages.isNotEmpty) {
      // Si des images sont sélectionnées, convertir chaque image en File et les ajouter à une liste
      selectedImages.value =
          selectedImages.where((file) => file.uri != index.uri).toList();
    }
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

  // Future<void> getGarageByOwnerId(String userId) async {
  //   loading.value = true;
  //   final result = await _getGarageByOwnerIdUseCase
  //       .call(GetGarageByOwnerIdCommand(userId: userId));
  //   result.fold(
  //     (e) {
  //       loading.value = false;
  //       Get.showCustomSnackBar(e.message);
  //     },
  //     (success) {
  //       myGarage = success;
  //       getVehicleList(myGarage!.id);
  //       Get.find<AppEventService>()
  //           .emit<String>(AppConstants.garageIdEvent, myGarage!.id);
  //       update();
  //       loading.value = false;
  //     },
  //   );
  // }

  // Future<void> getVehicleList(String garageId) async {
  //   vehicleLoading.value = true;
  //   final result = await _getVehicleListUseCase
  //       .call(GetVehicleListCommand(garageId: garageId));
  //   result.fold(
  //     (e) {
  //       vehicleLoading.value = false;
  //       Get.showCustomSnackBar(e.message);
  //     },
  //     (response) {
  //       vehicleList = response;
  //       print("vehicleList.toList()");

  //       print(response);
  //       update();
  //       vehicleLoading.value = false;
  //     },
  //   );
  // }

  Future<void> getPlaceDetails(String placeId) async {
    // loading.value = true;
    final result = await _getPlaceDetailsUseCase.call(placeId);
    result.fold(
      (e) {
        loading.value = false;
        Get.showCustomSnackBar(e.message);
      },
      (success) {
        placeDetails = success;
        placeInput.value = success.name;
        update();
        // loading.value = false;
      },
    );
  }

  Future<void> getPlaceAutocomplete(String input) async {
    // loading.value = true;
    final result = await _getPlaceAutocompleteUseCase.call(input);
    print("result");
    print(result);
    result.fold(
      (e) {
        loading.value = false;
        Get.showCustomSnackBar(e.message);
      },
      (success) {
        placePredictions.value = success;
        // loading.value = false;
      },
    );
  }
}
