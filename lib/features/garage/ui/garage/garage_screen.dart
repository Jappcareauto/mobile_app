import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/list_vehicle_widget.dart';
import '../../../../core/ui/interfaces/feature_widget_interface.dart';
import 'controllers/garage_controller.dart';
import 'package:get/get.dart';

import 'widgets/recent_activities_widget.dart';

class GarageScreen extends GetView<GarageController>
    implements FeatureWidgetInterface {
  const GarageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GarageController>(
      init: GarageController(Get.find(), Get.find()),
      autoRemove: false,
      initState: (_) {},
      builder: (_) {
        return Scaffold(
            appBar: CustomAppBar(
              title: "My Garage",
              canBack: true,
              actions: [
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'AvatarWidget'))
                  Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget')
                      .buildView(),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListVehicleWidget(haveTitle: false),
                    const SizedBox(height: 20),
                    RecentActivitiesWidget(haveTabBar: true),
                  ],
                ),
              ),
            ));
      },
    );
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
