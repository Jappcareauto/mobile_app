import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/list_veehicle_widget.dart';
import '../../../../core/ui/interfaces/feature_widget_interface.dart';
import 'controllers/garage_controller.dart';
import 'package:get/get.dart';

import 'widgets/recent_activities_widget.dart';

class GarageScreen extends GetView<GarageController>
    implements FeatureWidgetInterface {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "My Garage",
        canBack: true,
        actions: [
          ImageComponent(
            imageUrl: 'https://i.pravatar.cc/300',
            width: 50,
            height: 50,
            borderRadius: 40,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ListVehicleWidget(haveTitle: false),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const RecentActivitiesWidget(haveTabBar: true),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildView([args]) {
    return this;
  }
}
