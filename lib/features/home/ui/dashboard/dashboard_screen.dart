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
            showUnselectedLabels: true,
            iconSize: 25,
            unselectedItemColor: const Color(0xFF111111),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  FluentIcons.home_24_regular,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.access_time_rounded,
                ),
                label: 'Activities',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.maps_home_work_outlined),
                label: 'Workshops',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FluentIcons.store_microsoft_24_regular,
                ),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.directions_car_filled_outlined,
                ),
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
