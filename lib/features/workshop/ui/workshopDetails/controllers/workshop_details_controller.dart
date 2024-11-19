import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../core/navigation/app_navigation.dart';

class WorkshopDetailsController extends GetxController {
  final AppNavigation _appNavigation;
  WorkshopDetailsController(this._appNavigation);

  LatLng? userPosition;
  final loading = false.obs;
  final locationPermissionGranted = false.obs;

  //Maps initializations
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  var kYaounde = const CameraPosition(
    target: LatLng(3.8480, 11.5021),
    zoom: 13.4746,
  );
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    getPosition();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  //get position
  void getPosition() async {
    await _requestLocationPermission();
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    userPosition = LatLng(position.latitude, position.longitude);
    update();
    // missionsAroundMe();
    update();
  }

  //Maps methods
  Future<BitmapDescriptor> getCustomMarker() async {
    return await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(37, 37)), // Taille souhaitée
      AppImages.carWhite,
    );
  }

  Future<void> loadCustomMarker([bool isMission = false]) async {
    final customIcon = await getCustomMarker();
    markers.clear();
    // if (isMission) {
    //   markers.add(
    //     Marker(
    //       infoWindow: InfoWindow(title: mission!.packageName),
    //       markerId: MarkerId('marker${mission!.packageId}'),
    //       position: LatLng(mission!.senderLatitude, mission!.senderLongitude),
    //       icon: customIcon,
    //     ),
    //   );
    // } else if (missions != null && missions!.isNotEmpty) {
    //   for (var e in missions!) {
    //     markers.add(
    //       Marker(
    //         infoWindow: InfoWindow(title: e.packageName),
    //         markerId: MarkerId('marker${e.packageId}'),
    //         position: LatLng(e.senderLatitude, e.senderLongitude),
    //         icon: customIcon,
    //       ),
    //     );
    //   }
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      locationPermissionGranted.value = true;
    } else {
      _requestLocationPermission();
    }
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
}
