import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
// import 'package:jappcare/features/garage/application/usecases/get_place_name_use_case.dart';
import 'package:jappcare/features/workshop/application/command/get_service_center_services.dart';
import 'package:jappcare/features/workshop/application/usecases/get_service_center_services_usecase.dart';
import 'package:jappcare/features/workshop/domain/entities/service_center_service.entity.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../core/navigation/app_navigation.dart';

class WorkshopDetailsController extends GetxController {
  final AppNavigation _appNavigation;
  final garageController = Get.find<GarageController>();
  // Observers to manage the selection of the vehicle for the appointment
  final PageController pageController = PageController(
    viewportFraction: 0.9,
  );
  final RxInt currentPage = 0.obs;

  WorkshopDetailsController(this._appNavigation);

  LatLng? userPosition;
  // final GetPlaceNameUseCase _getPlaceNameUseCase = Get.find();
  final GetServiceCenterServicesUsecase _getServiceCenterServicesUseCase =
      Get.find();

  final serviceCenterServicesLoading = false.obs;
  RxList<ServiceCenterServiceEntity> serviceCenterServices =
      RxList<ServiceCenterServiceEntity>();

  final loading = false.obs;
  final locationLoading = false.obs;
  final locationPermissionGranted = false.obs;

  final globalWorkshopController = Get.find<GlobalcontrollerWorkshop>();
  final arguments = Get.find<GlobalcontrollerWorkshop>().workshopData;

  final RxList<Vehicle> vehicles = <Vehicle>[].obs;

  RxString placeName = ''.obs;

  //Maps initializations
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  var serviceLocation = BitmapDescriptor.defaultMarker.obs;

  var kYaounde = const CameraPosition(
    target: LatLng(3.8480, 11.5021),
    // zoom: 13.4746,
    zoom: 5,
  );
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    if (arguments['serviceCenterId'] != null) {
      vehicles.value = garageController.vehicleList
          .where((e) => e.serviceCenterId == arguments['serviceCenterId'])
          .toList();
      getAllServiceCenterServices(arguments['serviceCenterId']);
    }

    getPosition();

    pageController.addListener(() {
      int newPage = pageController.page!.round();
      if (currentPage.value != newPage) {
        currentPage.value = newPage;
      }
    });
  }

  void goBack() {
    _appNavigation.goBack();
  }

  Future<void> getAllServiceCenterServices(String serviceCenterId) async {
    serviceCenterServicesLoading.value = true;
    final result = await _getServiceCenterServicesUseCase.call(
        GetServiceCenterServicesCommand(serviceCenterId: serviceCenterId));
    result.fold(
      (e) {
        serviceCenterServicesLoading.value = false;
        if (Get.context != null) {
          Get.showCustomSnackBar(e.message);
        }
      },
      (response) {
        serviceCenterServicesLoading.value = false;
        serviceCenterServices.value = response.data;
      },
    );
  }

  // Future<void> getPlaceName() async {
  //   loading.value = true ;
  //   final result = await _getPlaceNameUseCase.call(
  //       GetPlaceNameCommand(longitude: arguments['longitude'], latitude: arguments['latitude']));
  //   result.fold(
  //           (error) {
  //         print(error.message);
  //         loading.value = false ;

  //       },
  //           (response) {
  //             placeName.value = response ;
  //             loading.value = false ;

  //             update();
  //       }

  //   );
  // }

  //get position
  void getPosition() async {
    locationLoading.value = true;
    await _requestLocationPermission();
    // final position = await Geolocator.getCurrentPosition(
    //   locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    // );
    // userPosition = LatLng(position.latitude, position.longitude);
    locationLoading.value = false;

    update();
    // missionsAroundMe();
    // update();
  }

  //Maps methods
  Future<BitmapDescriptor> getCustomMarker() async {
    return await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(37, 37)), // Taille souhaitée
      AppImages.carWhite,
    );
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      locationPermissionGranted.value = true;
    } else {
      _requestLocationPermission();
    }
  }

  Future<BitmapDescriptor> getCustomIcon() async {
    return await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)), // Taille de l'icône
      AppConstants.mapLocalisation, // Chemin vers l'icône dans vos assets
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width, // Redimensionner l'image
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    ByteData? byteData =
        await fi.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<void> loadCustomIcons() async {
    final Uint8List sevrviceIconBytes =
        await getBytesFromAsset(AppConstants.mapLocalisation, 37);
    serviceLocation.value = BitmapDescriptor.bytes(sevrviceIconBytes);
  }

  void addMarker(double latitude, double longitude) async {
    const markerId = MarkerId('custom-marker');
    await loadCustomIcons();
    final marker = Marker(
      markerId: markerId,
      position: LatLng(latitude, longitude),
      icon: serviceLocation.value, // Icône par défaut (rouge)
      infoWindow: InfoWindow(
        title: arguments['name'],
        snippet: 'Latitude: $latitude, Longitude: $longitude',
      ),
    );

    // Ajouter le marqueur au Set de marqueurs
    markers.add(marker);

    // Si vous utilisez une variable observable dans GetX
    update(); // Met à jour l'interface utilisateur
  }

  void goToLocation(double latitude, double longitude) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 6.0, // Niveau de zoom (ajustez selon vos besoins)
        ),
      ),
    );
  }

  void locatePoint(double latitude, double longitude) {
    addMarker(latitude, longitude); // Ajout du marqueur
    goToLocation(latitude, longitude); // Centrage de la carte
  }

  Future<void> ajusterCameraSurPoints(List<LatLng> points) async {
    final GoogleMapController controller = await mapController.future;
    if (points.isEmpty) return;
    LatLngBounds bounds;

    if (points.length == 1) {
      // Si un seul point, définir des limites autour de ce point
      var point = points.first;
      bounds = LatLngBounds(southwest: point, northeast: point);
    } else {
      // Trouver les limites sud-ouest et nord-est
      double minLat = points.first.latitude;
      double maxLat = points.first.latitude;
      double minLng = points.first.longitude;
      double maxLng = points.first.longitude;

      for (var point in points) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLng) minLng = point.longitude;
        if (point.longitude > maxLng) maxLng = point.longitude;
      }

      bounds = LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      );
    }

    // Ajuster la caméra pour englober les limites avec un padding de 50 pixels
    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    kYaounde = CameraPosition(
      target: LatLng(userPosition!.latitude, userPosition!.longitude),
      zoom: 13.4746,
    );
    controller.animateCamera(cameraUpdate);
  }

  void gotoBookAppointment() {
    _appNavigation.toNamed(WorkshopPrivateRoutes.bookappointment);
    globalWorkshopController.addData(
      "serviceCenterServices",
      serviceCenterServices,
    );
  }
}
