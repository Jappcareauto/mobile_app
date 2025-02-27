import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jappcare/features/workshop/ui/workshopDetails/controllers/workshop_details_controller.dart';
import '../../../../../core/ui/interfaces/feature_widget_interface.dart';

class WorkshopCustomMapView extends StatelessWidget implements FeatureWidgetInterface {
  const WorkshopCustomMapView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WorkshopDetailsController(Get.find()));

    return Expanded(
        child: MixinBuilder<WorkshopDetailsController>(
      initState: (_) {},
      builder: (_) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
          child:  ClipRRect(
            borderRadius:
            const BorderRadius.all(Radius.circular(32)),
            child: controller.locationPermissionGranted.value
                ? GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _.kYaounde,
              markers: _.markers, // Set de marqueurs
              polylines: _.polylines,
              onMapCreated: (GoogleMapController c) {
                _.mapController.complete(c);
                _.locatePoint(_.arguments['latitude'] , _.arguments['longitude']); // Exemple de coordonnées (Latitude, Longitude)
              },
            )
                : const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:50),
                child: Text(
                  "Location permission is required",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        );

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
