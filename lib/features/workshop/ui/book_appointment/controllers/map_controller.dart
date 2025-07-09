import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/events/app_events_service.dart';
import 'dart:async';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

import 'package:jappcare/core/utils/app_constants.dart';

class MapController extends GetxController {
  final GarageController _garageController =
      GarageController(Get.find(), Get.find());
  final loading = true.obs;
  // final vehicleLoading = true.obs;
  final AppNavigation _appNavigation;
  // final arguments = Get.arguments;
  final locationPermissionGranted = false.obs;
  final Completer<GoogleMapController> mapController = Completer();
  final Rx<BitmapDescriptor> serviceLocation =
      BitmapDescriptor.defaultMarker.obs;
  Set<Marker> markers = {};
  var kYaounde = const CameraPosition(
    target: LatLng(3.8480, 11.5021),
    zoom: 5,
  );

  MapController(this._appNavigation);

  @override
  void onInit() {
    super.onInit();
    _requestLocationPermission();
    loadCustomIcons();
    Get.find<AppEventService>()
        .on<String>(AppConstants.userIdEvent)
        .listen((userId) {
      if (userId != '') _garageController.getGarageByOwnerId(userId!);
    });
    if (Get.find<AppEventService>().getLastValue(AppConstants.userIdEvent) !=
        null) {
      loading.value = false;
      // vehicleLoading.value = false;
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    try {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width,
      );
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();
    } catch (e) {
      print("Error loading asset: $e");
      rethrow;
    }
  }

  Future<void> loadCustomIcons() async {
    final Uint8List serviceIconBytes =
        await getBytesFromAsset(AppConstants.mapLocalisation, 150);
    serviceLocation.value = BitmapDescriptor.bytes(serviceIconBytes);
  }

  void clearMarkers() {
    markers.clear();
    update();
    update();
  }

  void addMarker(double latitude, double longitude, String? placeName) async {
    await loadCustomIcons();
    final marker = Marker(
      markerId: const MarkerId('custom-marker'),
      position: LatLng(latitude, longitude),
      icon: serviceLocation.value,
      infoWindow: InfoWindow(
        title: placeName,
        snippet: 'Latitude: $latitude, Longitude: $longitude',
      ),
    );
    print('marker added');
    markers.add(marker);
    update();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      locationPermissionGranted.value = true;
    }
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

  void locatePoint(
      {required double latitude,
      required double longitude,
      String? placeName}) {
    addMarker(latitude, longitude, placeName); // Ajout du marqueur
    goToLocation(latitude, longitude); // Centrage de la carte
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
