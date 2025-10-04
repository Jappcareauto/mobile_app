import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/events/app_events_service.dart';
import 'dart:async';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:path_provider/path_provider.dart';
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
    requestLocationPermission();
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

  Future<BitmapDescriptor> getBitmapDescriptorFromSvgAsset(
      String assetName, double size) async {
    final picture = await vg.loadPicture(SvgAssetLoader(assetName), null);

    final image = await picture.picture.toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/temp_marker.png');
    await tempFile.writeAsBytes(byteData!.buffer.asUint8List());

    return BitmapDescriptor.bytes(await tempFile.readAsBytes());
  }

//   Future<Uint8List> svgToBytes(String assetName) async {
//   final svgString = await rootBundle.loadString(assetName);
//   final svgDrawable = await svg.fromSvgString(svgString, assetName);
//   final picture = svgDrawable.toPicture();
//   final ui.Image image = await picture.toImage(200, 200); // resize to 200x200
//   final ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//   return byteData!.buffer.asUint8List();
// }

  Future<void> loadCustomIcons() async {
    final BitmapDescriptor serviceIconBytes =
        // await getBytesFromAsset(AppConstants.mapLocalisation, 200);
        await getBitmapDescriptorFromSvgAsset(AppConstants.localisation, 50);
    serviceLocation.value = serviceIconBytes;
  }

  void clearMarkers() {
    markers.clear();
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

  Future<void> requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.request();
    print("s, ${status.isGranted}");
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
