import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/controllers/services_locator_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapWiget extends GetView<ServicesLocatorController> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: controller.initialPosition,
        myLocationEnabled: true,  // Affiche la position actuelle
        onMapCreated: (GoogleMapController mapController) {
          controller.onMapCreated(mapController);
        },
      ),
    );
  }

}