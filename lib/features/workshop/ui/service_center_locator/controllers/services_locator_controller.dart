import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_pages.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:permission_handler/permission_handler.dart';
class ServicesLocatorController extends GetxController {
  final AppNavigation _appNavigation;
  ServicesLocatorController(this._appNavigation);
  // Completer for GoogleMap controller
  Completer<GoogleMapController> _controller = Completer();
  var isLocationPermissionGranted = false.obs;
  final isExpanded = false.obs;
  var bottomSheetHeight = 260.0.obs;
  final CameraPosition initialPosition = CameraPosition(
    target: LatLng(3.848000, 11.502100),
    zoom: 14.0,
  );
  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }
  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
    print('container cliquer ');
    bottomSheetHeight.value = isExpanded.value ? Get.height * 0.4 : 260.0;
  }

  // Function to be called when map is created
  void onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }
  void gottoautoshopDetail() {
     print('got to auto shop detail');
     _appNavigation.toNamed(WorkshopPrivateRoutes.workshopDetails);
  }
  Future<void> _checkLocationPermission() async {
    var status = await Permission.location.status;

    // Si la permission est refusée ou restreinte, demandez-la
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      var result = await Permission.location.request();
      if (result.isGranted) {
        // Permission accordée
        print("Permission accordée");
        isLocationPermissionGranted.value = true;
      } else if (result.isDenied) {
        // Permission refusée (encore une fois)
        print("Permission refusée");
        Get.snackbar('Permission', 'Location permission is required to show the map.');
      } else if (result.isPermanentlyDenied) {
        // Permission refusée de façon permanente, redirigez l'utilisateur vers les paramètres
        await openAppSettings();
      }
    } else if (status.isGranted) {
      // Permission déjà accordée
      isLocationPermissionGranted.value = true;
    }
  }

}
