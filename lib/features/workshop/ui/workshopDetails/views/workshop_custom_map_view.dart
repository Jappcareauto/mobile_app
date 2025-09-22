import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/custom_map_widget.dart';
import 'package:jappcare/features/workshop/ui/workshopDetails/controllers/workshop_details_controller.dart';
import '../../../../../core/ui/interfaces/feature_widget_interface.dart';
// import 'package:shimmer/shimmer.dart';

class WorkshopCustomMapView extends StatelessWidget
    implements FeatureWidgetInterface {
  const WorkshopCustomMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: MixinBuilder<WorkshopDetailsController>(
      initState: (_) {},
      builder: (controller) {
        return CustomMapWidget(
          latitude: controller.arguments['latitude'],
          longitude: controller.arguments['longitude'],
          placeName: controller.arguments['locationName'],
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
