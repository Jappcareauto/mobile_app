import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/list_veehicle_widget.dart';
import '../../../../core/ui/interfaces/feature_widget_interface.dart';
import 'controllers/garage_controller.dart';
import 'package:get/get.dart';

import 'widgets/recent_activities_widget.dart';

class GarageScreen extends GetView<GarageController>
    implements FeatureWidgetInterface {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GarageController>(
      init: GarageController(Get.find()),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
            appBar: CustomAppBar(
              title: controller.loading.value
                  ? "My Garage"
                  : controller.myGarage?.name ?? "My Garage",
              canBack: true,
              actions: [
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'AvatarWidget'))
                  Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget')
                      .buildView(),
              ],
            ),
            body: const SingleChildScrollView(
              child: Column(
                children: [
                  ListVehicleWidget(haveTitle: false),
                  SizedBox(height: 20),
                  RecentActivitiesWidget(haveTabBar: true),
                ],
              ),
            ));
      },
    );
  }

  @override
  Widget buildView([args]) {
    return this;
  }
}
