import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/features/home/ui/home/home_screen.dart';
import 'controllers/dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: Obx(() => Container(
            child: [
              HomeScreen(),
              Container(),
              Container(),
              Container(),
              Container(),
              // const ActivitiesHome(),
              // const WorkshopHome(),
              // const HomeShopScreen(),
              // const MyGarage(),
            ][controller.selectedIndex.value],
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
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
              BottomNavigationBarItem(
                icon: Icon(
                  controller.selectedIndex.value == 1
                      ? FluentIcons.clock_24_filled
                      : FluentIcons.clock_24_regular,
                ),
                label: 'Activities',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  controller.selectedIndex.value == 2
                      ? FluentIcons.home_garage_24_filled
                      : FluentIcons.home_garage_24_regular,
                ),
                label: 'Workshops',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  controller.selectedIndex.value == 3
                      ? FluentIcons.building_shop_24_filled
                      : FluentIcons.building_shop_24_regular,
                ),
                label: 'Shop',
              ),
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
