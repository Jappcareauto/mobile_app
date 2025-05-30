import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jappcare/features/workshop/ui/workshopDetails/controllers/workshop_details_controller.dart';
import '../../../../../core/ui/interfaces/feature_widget_interface.dart';
import 'package:shimmer/shimmer.dart';

class WorkshopCustomMapView extends StatelessWidget
    implements FeatureWidgetInterface {
  const WorkshopCustomMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: MixinBuilder<WorkshopDetailsController>(
      initState: (_) {},
      builder: (controller) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(32)),
              child: controller.locationPermissionGranted.value
                  ? controller.locationLoading.value
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: 300, // height of the map
                            color: Colors.white,
                          ),
                        )
                      : GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: controller.kYaounde,
                          markers: controller.markers, // Set de marqueurs
                          polylines: controller.polylines,
                          onMapCreated: (GoogleMapController c) {
                            controller.mapController.complete(c);
                            controller.locatePoint(
                                controller.arguments['latitude'],
                                controller.arguments[
                                    'longitude']); // Exemple de coordonnées (Latitude, Longitude)
                          },
                        )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          "Location permission is required",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ));
      },
    ));
  }

  @override
  Widget buildView([args]) {
    return this;
  }

  @override
  void refreshData() {
    // TODO: implement refreshData
  }
}
