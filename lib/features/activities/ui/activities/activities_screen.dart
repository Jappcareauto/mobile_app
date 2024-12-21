import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/chat_widget.dart';
import 'controllers/activities_controller.dart';
import 'package:get/get.dart';

class ActivitiesScreen extends GetView<ActivitiesController>
    implements FeatureWidgetInterface {
  final GarageController garageController =
      Get.put(GarageController(Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Activities",
          canBack: false,
          actions: [
            if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
          ],
        ),
        body: Stack(
          children: [
            garageController.vehicleList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImageComponent(
                          assetPath: AppImages.noActivities,
                        ),
                        Column(
                          children: [
                            Text(
                              'You have no recent activities',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            Text(
                              'at the moment',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        if (Get.isRegistered<FeatureWidgetInterface>(
                            tag: 'RecentActivitiesWidget'))
                          Get.find<FeatureWidgetInterface>(
                                  tag: 'RecentActivitiesWidget')
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
                          Get.find<FeatureWidgetInterface>(
                                  tag: 'RecentActivitiesWidget')
                              .buildView(),
                      ],
                    ),
                  ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.65,
                right: 10,
                child: ChatWidget())
          ],
        ));
  }

  @override
  Widget buildView([args]) {
    return this;
  }
}
