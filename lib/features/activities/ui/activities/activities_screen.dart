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
      Get.put(GarageController(Get.find(), Get.find()));

  ActivitiesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appBarcolor: Get.theme.scaffoldBackgroundColor,
          title: "Activities",
          canBack: false,
          actions: [
            if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
          ],
        ),
        body: MixinBuilder<ActivitiesController>(
          init: ActivitiesController(Get.find()),
          initState: (_) {},
          builder: (controller) {
            return Stack(
              children: [
                garageController.appointments.isEmpty
                    ? const Center(
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
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                Text(
                                  'at the moment',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
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
                                'status': 'IN_PROGRESS',
                                'isHorizontal': true
                              }),
                            //RecentActivitiesWidget
                            if (Get.isRegistered<FeatureWidgetInterface>(
                                tag: 'RecentActivitiesWidget')) ...[
                              const SizedBox(height: 40),
                              Get.find<FeatureWidgetInterface>(
                                      tag: 'RecentActivitiesWidget')
                                  .buildView(),
                            ]
                          ],
                        ),
                      ),
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .62,
                        left: MediaQuery.of(context).size.width * .85),
                    child: ChatWidget(
                      onTap: () {
                        print("Tapped");
                        controller.goToChatScreen();
                      },
                    ))
              ],
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
