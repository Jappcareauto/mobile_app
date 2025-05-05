import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/map_controller.dart';
import 'package:jappcare/features/workshop/ui/workshopDetails/controllers/workshop_details_controller.dart';

class CustomMapWidget extends GetView<MapController> {
  final WorkshopDetailsController workshopcontroller =
      Get.put(WorkshopDetailsController(Get.find()));
  // final WorkshopDetailsController workshopcontroller =
  //     Get.put(WorkshopDetailsController(Get.find()));

  CustomMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 300,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Obx(() {
            return controller.locationPermissionGranted.value
                ? GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: controller.kYaounde,
                    markers: controller.markers,
                    onMapCreated: (GoogleMapController c) {
                      if (!controller.mapController.isCompleted) {
                        controller.mapController.complete(c);
                      }
                      controller.locatePoint(
                        controller.arguments['latitude'],
                        controller.arguments['longitude'],
                      );
                    },
                  )
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.all(50),
                      child: Text(
                        "Location permission is required",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
          })),
    );
  }
}
