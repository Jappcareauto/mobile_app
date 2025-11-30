import 'dart:async';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:jappcare/core/events/app_events_service.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
// import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
// import 'package:jappcare/features/garage/application/usecases/get_garage_by_owner_id_command.dart';
// import 'package:jappcare/features/garage/application/usecases/get_garage_by_owner_id_usecase.dart';
// import 'package:jappcare/features/garage/application/usecases/get_vehicle_list_command.dart';
// import 'package:jappcare/features/garage/application/usecases/get_vehicle_list_usecase.dart';
// import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/features/workshop/application/usecases/get_place_latlng_usecase.dart';
import 'package:jappcare/features/workshop/domain/entities/geocode_position.dart';
import 'package:jappcare/features/workshop/domain/entities/service_center_service.entity.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:jappcare/features/workshop/application/usecases/get_place_autocomplete_usecase.dart';
import 'package:jappcare/features/workshop/application/usecases/get_place_details_usecase.dart';
import 'package:jappcare/features/workshop/domain/entities/place_prediction.dart';
import 'package:jappcare/features/workshop/domain/entities/place_details.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

class BookAppointmentController extends GetxController {
  final AppNavigation _appNavigation;
  final garageController = Get.find<GarageController>();

  var selectedDate = DateTime.now().obs;
  var selectedYear = DateTime.now().year.obs; // Année actuelle
  var selectedMonth = DateTime.now().month.obs; // Mois actuel
  RxString selectedTime = "MORNING".obs;
  RxString selectedTimeRange = "8am-12am".obs;

  var selectedImages = <File>[].obs;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  // final GetGarageByOwnerIdUseCase _getGarageByOwnerIdUseCase = Get.find();
  // final GetVehicleListUseCase _getVehicleListUseCase = Get.find();

  final Uuid _uuid = const Uuid();

  // A new session token should be generated for each autocomplete session.
  String? _sessionToken;

  final loading = true.obs;
  final vehicleLoading = true.obs;

  // Selected service observables
  final RxList<ServiceCenterServiceEntity> serviceCenterServices =
      <ServiceCenterServiceEntity>[].obs;
  // final RxList<Vehicle> vehicles = <Vehicle>[].obs;
  final selectedServiceId = ''.obs;
  final selectedServiceName = ''.obs;
  final RxInt selectedServicePrice = 0.obs;
  final selectedServiceIndex = 0.obs;

  // Observables to manage the vehicles
  final vehicleId = ''.obs;
  final vehicleVin = ''.obs;
  // List<Vehicle> vehicleList = [];

  late GlobalcontrollerWorkshop globalControllerWorkshop;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // The location state of the form
  RxString selectedLocation = "SERVICE_CENTER".obs;
  RxString placeInput = "".obs;
  RxList<PlacePrediction> placePredictions = <PlacePrediction>[].obs;
  Rx<PlaceDetails?> placeDetails = Rx<PlaceDetails?>(null); // placeDetails;
  final GetPlaceDetailsUseCase _getPlaceDetailsUseCase = Get.find();
  final GetPlaceAutocompleteUsecase _getPlaceAutocompleteUseCase = Get.find();
  final GetPlaceLatLngUseCase _getPlaceLatLngUseCase = Get.find();
  // End on the location state of the form

  // Fields for google geolocation
  // Controller for Google Maps.
  final Completer<GoogleMapController> mapController = Completer();
  // The user's current position.
  // Position? _currentPosition;
  // Set of markers to display on the map.
  final Set<Marker> markers = {};
  // Initial camera position (e.g., a default central location).
  final kYaounde = CameraPosition(
    target: LatLng(3.8480, 11.5021),
    zoom: 5,
  );

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
    globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();
    // Listener pour synchroniser la page actuelle
    serviceCenterServices.value =
        globalControllerWorkshop.workshopData['serviceCenterServices']
            as List<ServiceCenterServiceEntity>;

    // if (globalControllerWorkshop.workshopData['serviceCenterId'] != null) {
    //   vehicles.value = garageController.vehicleList
    //       .where((e) =>
    //           e.serviceCenterId ==
    //           globalControllerWorkshop.workshopData['serviceCenterId'])
    //       .toList();
    // }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (serviceCenterServices.isNotEmpty) {
        selectedServiceId.value = serviceCenterServices[0].service.id;
        selectedServiceName.value = serviceCenterServices[0].service.title;
        if (serviceCenterServices[0].price != null) {
          selectedServicePrice.value = serviceCenterServices[0].price!.round();
        }
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

    // Listen for location input changes
    locationController.addListener(() {
      placeInput.value = locationController.text;
      if (_sessionToken == null && locationController.text.isNotEmpty) {
        _sessionToken = _uuid.v4();
        update();
      }
    });

    pageController.addListener(() {
      int newPage = pageController.page!.round();
      if (currentPage.value != newPage) {
        currentPage.value = newPage;
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
    // print(vehicles);
    // print(vehicles[currentPage.value]);
    globalControllerWorkshop.addMultipleData({
      "selectedDate": selectedDate.value,
      "selectedLocation": selectedLocation.value,
      "serviceName": selectedServiceName.value,
      "servicePrice": selectedServicePrice.value,
      "serviceId": selectedServiceId.value,
      "noteController": noteController.text,
      "vehicle": garageController.vehicleList[currentPage.value],
      "selectedTime": selectedTime.value,
      "selectedTimeRange": selectedTimeRange.value,
      "location": placeDetails.value,
    });
    globalControllerWorkshop.setImages(selectedImages);
  }

  void goBack() {
    _appNavigation.goBack();
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

  Future<void> getPlaceDetails(String placeId) async {
    loading.value = true;
    final result =
        await _getPlaceDetailsUseCase.call(placeId, _sessionToken ?? "");
    result.fold(
      (e) {
        loading.value = false;
        Get.showCustomSnackBar(e.message);
      },
      (success) {
        loading.value = false;
        placeDetails.value = success;
        placeInput.value = success.name;
        locationController.text = success.name;
        placePredictions.value = [];
        update();
        // loading.value = false;
      },
    );
  }

  Future<void> getPlaceAutocomplete(String input) async {
    // loading.value = true;
    final result =
        await _getPlaceAutocompleteUseCase.call(input, _sessionToken ?? "");
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

  /// The main function to get the user's location and update the map.
  Future<void> getUserLocationAndAnimateCamera() async {
    // 1. Check and request location permissions.
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showPermissionDeniedDialog();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showPermissionDeniedDialog(isPermanentlyDenied: true);
      return;
    }

    // 2. Get the current location if permissions are granted.
    try {
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
      );

      // _currentPosition = position;
      // print('Current position: $position');

      GeocodePosition? place = await getPlacemark(position);
      if (place != null) {
        // print(
        //     'Current location: ${place.street}, ${place.locality}, ${place.country}');
        clearMarkers(); // Clear old markers

        addMarker(
          position.latitude,
          position.longitude,
          place.formattedAddress,
        );
      }

      // 4. Animate the map camera to the new position.
      final GoogleMapController controller = await mapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 16.0,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error getting location: $e');
      // Optionally, show an error message to the user
    }
  }

  void clearMarkers() {
    markers.clear();
    update();
  }

  void addMarker(double latitude, double longitude, String? placeName) async {
    // await loadCustomIcons();
    final marker = Marker(
      markerId: const MarkerId('custom-marker'),
      position: LatLng(latitude, longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      infoWindow: InfoWindow(
        title: placeName,
        snippet: 'Latitude: $latitude, Longitude: $longitude',
      ),
    );
    print('marker added');
    markers.add(marker);
    update();
  }

  // void locatePoint(
  //     {required double latitude,
  //     required double longitude,
  //     String? placeName}) {
  //   addMarker(latitude, longitude, placeName); // Ajout du marqueur
  //   goToLocation(latitude, longitude); // Centrage de la carte
  // }

  Future<GeocodePosition?> getPlacemark(Position position) async {
    GeocodePosition? location;
    final result = await _getPlaceLatLngUseCase.call(
        position.latitude, position.longitude);
    result.fold(
      (e) {
        // locationLoading.value = false;
        Get.showCustomSnackBar(e.message);
      },
      (success) {
        // locationLoading.value = false;
        placeDetails.value = PlaceDetails.create(
            name: success.formattedAddress,
            lat: position.latitude,
            lng: position.longitude);
        location = success;
        update();

        return success;
      },
    );
    return location;
  }

  void goToLocation(double latitude, double longitude) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 14.0, // Niveau de zoom (ajustez selon vos besoins)
        ),
      ),
    );
  }

  /// Shows a dialog explaining why the permission is needed.
  void _showPermissionDeniedDialog({bool isPermanentlyDenied = false}) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Location Permission Denied'),
        content: Text(isPermanentlyDenied
            ? 'Location permission is permanently denied. Please go to your device settings to enable it for this app.'
            : 'Location permission is required to find and display your current location on the map.'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              goBack();
              if (isPermanentlyDenied) {
                Geolocator.openAppSettings();
              }
            },
          ),
        ],
      ),
    );
  }
}
