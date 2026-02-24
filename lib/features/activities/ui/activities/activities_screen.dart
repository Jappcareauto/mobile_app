import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/generated/locales.g.dart';
import 'controllers/activities_controller.dart';
import 'package:get/get.dart';

class ActivitiesScreen extends GetView<ActivitiesController>
    implements FeatureWidgetInterface {
  final GarageController garageController = Get.find<GarageController>();

  ActivitiesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appBarcolor: Get.theme.scaffoldBackgroundColor,
          title: LocaleKeys.activities.tr,
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
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const ImageComponent(
                              assetPath: AppImages.noActivities,
                            ),
                            Text(
                              LocaleKeys.no_recent_activities.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
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
                // Container(
                //     margin: EdgeInsets.only(
                //         top: MediaQuery.of(context).size.height * .60,
                //         left: MediaQuery.of(context).size.width * .80),
                //     child: ChatWidget(
                //       onTap: () {
                //         controller.goToChatScreen();
                //       },
                //     ))
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
