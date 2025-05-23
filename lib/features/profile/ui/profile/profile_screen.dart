import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/features/profile/ui/profile/widgets/avatar_widget.dart';
import 'controllers/profile_controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarcolor: Get.theme.scaffoldBackgroundColor,
        title: "Profile",
        actions: [
          IconButton(
              onPressed: controller.goToSettings,
              icon: const Icon(FluentIcons.settings_24_regular))
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          elevation: 1.0,
          onRefresh: controller.getUserInfos,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              controller.loading.value
                                  ? const SizedBox()
                                  : Text(
                                      controller.userInfos?.name ??
                                          "Unknown name",
                                      style: Get.textTheme.headlineLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700),
                                    ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 130,
                                child: CustomButton(
                                    text: "Manage",
                                    onPressed: controller.goToSettings,
                                    borderRadius: BorderRadius.circular(30),
                                    haveBorder: true),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const AvatarWidget(size: 100, canEdit: false)
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'ListVehicleWidget'))
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Get.find<FeatureWidgetInterface>(
                            tag: 'ListVehicleWidget')
                        .buildView({
                      "pageController": controller.pageController,
                      "currentPage": controller.currentPage,
                      "haveAddVehicule": true,
                      "title": "My Garage",
                      "onTapeAddVehicle": () {
                        print("clique");
                      },
                    }),
                  ),
                const SizedBox(height: 20),
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'RecentActivitiesWidget'))
                  Get.find<FeatureWidgetInterface>(
                          tag: 'RecentActivitiesWidget')
                      .buildView(true),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
