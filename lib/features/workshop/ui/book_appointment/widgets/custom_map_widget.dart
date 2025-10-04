// import 'package:flutter/cupertino.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/map_controller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/full_screen_map_view.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/location_permission_placeholder.dart';
// import 'package:jappcare/features/workshop/ui/workshopDetails/controllers/workshop_details_controller.dart';

class CustomMapWidget extends GetView<MapController> {
  // final WorkshopDetailsController workshopcontroller =
  //     Get.put(WorkshopDetailsController(Get.find()));
  // final WorkshopDetailsController workshopcontroller =
  //     Get.put(WorkshopDetailsController(Get.find()));
  final double longitude;
  final double latitude;
  final String? placeName;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final bool isFullScreen;

  const CustomMapWidget(
      {super.key,
      this.longitude = 0,
      this.latitude = 0,
      this.margin,
      this.height = 300,
      this.placeName,
      this.isFullScreen = false});

  Widget mapWidget(MapController controller) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: controller.kYaounde,
      markers: controller.markers,
      onMapCreated: (GoogleMapController c) {
        if (!controller.mapController.isCompleted) {
          controller.mapController.complete(c);
        }
        // if (latitude == 0 && longitude == 0) {
        //   controller.clearMarkers();
        // }
        if (latitude != 0 && longitude != 0) {
          controller.locatePoint(
              latitude: latitude, longitude: longitude, placeName: placeName);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(controller.markers);
    return GetBuilder<MapController>(
        init: MapController(Get.find()),
        initState: (_) {},
        builder: (controller) {
          return Obx(
            () {
              return controller.locationPermissionGranted.value
                  ? Container(
                      margin: margin,
                      height: height,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: mapWidget(controller),
                          ),

                          // Fullscreen button
                          if (isFullScreen)
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(200),
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () => {
                                      Get.to(
                                        () => FullscreenMapView(
                                          mapWidget: mapWidget(controller),
                                          // goToLocation: () => controller.goToLocation(latitude, longitude),
                                        ),
                                        transition: Transition.fadeIn,
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.easeInOut,
                                      )
                                    },
                                    borderRadius: BorderRadius.circular(50),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Icon(
                                        FluentIcons.arrow_expand_20_regular,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ))
                  // : const Center(
                  //     child: Padding(
                  //       padding: EdgeInsets.all(50),
                  //       child: Text(
                  //         "Location permission is required",
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //   );
                  : LocationPermissionPlaceholder(
                      primaryColor:
                          Get.theme.primaryColor, // Customize your color
                      backgroundColor:
                          Get.theme.primaryColor.withValues(alpha: 0.1),
                      // onRequestPermission: controller.requestLocationPermission,
                      margin: margin,
                    );
            },
          );
        });
  }
}
