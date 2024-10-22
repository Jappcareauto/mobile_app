import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'controllers/activities_controller.dart';
import 'package:get/get.dart';

class ActivitiesScreen extends GetView<ActivitiesController>
    implements FeatureWidgetInterface {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Activities"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (Get.isRegistered<FeatureWidgetInterface>(
                tag: 'RecentActivitiesWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'RecentActivitiesWidget')
                  .buildView({
                'haveTabBar': false,
                'haveTitle': true,
                'title': 'In Progress Activities',
                'status': 'In Progress',
                'isHorizontal': true
              }),
            const SizedBox(height: 20),
            //RecentActivitiesWidget
            if (Get.isRegistered<FeatureWidgetInterface>(
                tag: 'RecentActivitiesWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'RecentActivitiesWidget')
                  .buildView(),
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
