import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/loading_widget.dart';
import 'package:jappcare/features/home/ui/home/home_screen.dart';
import 'controllers/dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: Obx(() => controller.loading.value
          ? LoaderWidget(dense: true)
          : Container(
              child: [
                const HomeScreen(),
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'ActivitiesScreen'))
                  Get.find<FeatureWidgetInterface>(tag: 'ActivitiesScreen')
                      .buildView(),
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'WorkshopScreen'))
                  Get.find<FeatureWidgetInterface>(tag: 'WorkshopScreen')
                      .buildView(),
                if (Get.isRegistered<FeatureWidgetInterface>(tag: 'ShopScreen'))
                  Get.find<FeatureWidgetInterface>(tag: 'ShopScreen')
                      .buildView(),
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'GarageScreen'))
                  Get.find<FeatureWidgetInterface>(tag: 'GarageScreen')
                      .buildView(),
                // const ActivitiesHome(),
                // const WorkshopHome(),
                // const HomeShopScreen(),
              ][controller.selectedIndex.value],
            )),
      bottomNavigationBar: Obx(() => controller.loading.value
          ? const SizedBox()
          : BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              iconSize: 25,
              unselectedItemColor: const Color(0xFF111111),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    controller.selectedIndex.value == 0
                        ? FluentIcons.home_24_filled
                        : FluentIcons.home_24_regular,
                  ),
                  label: 'Home',
                ),
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'ActivitiesScreen'))
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.selectedIndex.value == 1
                          ? FluentIcons.clock_24_filled
                          : FluentIcons.clock_24_regular,
                    ),
                    label: 'Activities',
                  ),
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'WorkshopScreen'))
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.selectedIndex.value == 2
                          ? FluentIcons.home_garage_24_filled
                          : FluentIcons.home_garage_24_regular,
                    ),
                    label: 'Workshops',
                  ),
                if (Get.isRegistered<FeatureWidgetInterface>(tag: 'ShopScreen'))
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.selectedIndex.value == 3
                          ? FluentIcons.building_shop_24_filled
                          : FluentIcons.building_shop_24_regular,
                    ),
                    label: 'Shop',
                  ),
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'GarageScreen'))
                  BottomNavigationBarItem(
                    icon: Icon(controller.selectedIndex.value == 4
                        ? FluentIcons.vehicle_cab_24_filled
                        : FluentIcons.vehicle_cab_24_regular),
                    label: 'Garage',
                  ),
              ],
              currentIndex: controller.selectedIndex.value,
              selectedItemColor: Get.theme.primaryColor,
              onTap: controller.onItemTapped,
            )),
    );
  }
}
