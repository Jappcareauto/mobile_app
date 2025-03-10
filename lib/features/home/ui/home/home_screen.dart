import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/app_bar_with_salutation.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/features/home/ui/home/widgets/dismiss_widget.dart';
import 'package:jappcare/features/home/ui/home/widgets/service_widget.dart';
import 'package:jappcare/features/home/ui/home/widgets/tip_modal_bottom.dart';
import 'package:jappcare/features/home/ui/home/widgets/title_section.dart';
import '../../../../core/utils/app_images.dart';
import 'controllers/home_controller.dart';
import 'widgets/notification_widget.dart';

class HomeScreen extends GetView<HomeController> {
  final GarageController garageController =
      Get.put(GarageController(Get.find(), Get.find()));

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController(Get.find()));
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) =>
                [const AppBarWithAvatarAndSalutation()],
            body: RefreshIndicator(
              onRefresh: controller.refreshData,
              color: const Color(0xFFFB7C37),
              strokeWidth: 3.0,
              backgroundColor: AppColors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: controller.notifications
                                .asMap()
                                .entries
                                .map((entry) {
                              final index = entry.key;
                              final notification = entry.value;

                              return Dismissible(
                                key: Key(notification),
                                direction: DismissDirection.endToStart,
                                background: const DismissWidget(),
                                onDismissed: (direction) {
                                  // Action après la suppression
                                  controller.notifications.removeAt(index);
                                },
                                child: NotificationWidget(
                                  haveTitle: true,
                                  textSize: 16,
                                  backgrounColor: const Color(0xFFFFEDE6),
                                  title: "Notification",
                                  bodyText: notification,
                                  coloriage: Get.theme.primaryColor,
                                  icon: FluentIcons.alert_16_filled,
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          NotificationWidget(
                            haveTitle: true,
                            backgrounColor: const Color(0xFFF4EEFF),
                            title: "Tip",
                            bodyText:
                                'Rotate your tires regulary to ensure they wear evenly and last longer.',
                            coloriage: Get.theme.colorScheme.secondary,
                            icon: FluentIcons.question_16_filled,
                            onTap: openModalTipsMethod,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    if (Get.isRegistered<FeatureWidgetInterface>(
                        tag: 'ListVehicleWidget'))
                      Get.find<FeatureWidgetInterface>(tag: 'ListVehicleWidget')
                          .buildView({
                        "pageController": controller.pageController,
                        "currentPage": controller.currentPage,
                        "haveAddVehicule": true,
                        "title": "My Garage",
                        "onTapeAddVehicle": () {
                          print("clique");
                        },
                      }),
                    const SizedBox(height: 20),
                    if (Get.isRegistered<FeatureWidgetInterface>(
                        tag: 'RecentActivitiesWidget'))
                      Get.find<FeatureWidgetInterface>(
                              tag: 'RecentActivitiesWidget')
                          .buildView({
                        'haveTabBar': false,
                        'haveTitle': true,
                        'title': 'Upcoming Activities',
                        'status': 'Completed',
                        'isHorizontal': false
                      }),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          GestureDetector(
                            child: const TitleSection(nameSection: 'Services'),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomCardService(
                                  color: const Color(0xFFFFEDE6),
                                  text: 'Find a Service\nCenter',
                                  imagePath: AppImages.service,
                                  onTap: () {
                                    // controller.goToVehicleFinder();
                                    controller.navigateTCommingSoon();
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomCardService(
                                  color: const Color(0xFFFFDAD4),
                                  text: 'Emergency\nAssistance',
                                  imagePath: AppImages.emergency,
                                  onTap: () {
                                    // controller.goToEmergency();
                                    controller.navigateTCommingSoon();
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child:
                          //       CustomCardService(
                          //         color: Color(0xFFF4EEFF),
                          //         text: 'VIN\nLookup',
                          //         imagePath: AppImages.vin,
                          //         onTap: () {
                          //           controller.navigateTCommingSoon();
                          //
                          //         },
                          //       ),
                          //     ),
                          //     const SizedBox(width: 10),
                          //     Expanded(
                          //       child:CustomCardService(
                          //         color: Color(0xFFC4FFCD),
                          //         text: 'Vehicles\nReports',
                          //         imagePath: AppImages.vehicule,
                          //         onTap: controller.navigateTCommingSoon
                          //
                          //         ,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
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
            )));
  }
}

void openModalTipsMethod() {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true, // Permet un contrôle précis sur la hauteur
    backgroundColor: Colors.transparent, // Rendre l'arrière-plan transparent
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16), // Espacement intérieur
          child: const Wrap(
            children: [TipModalBottomWidget()],
          ),
        ),
      );
    },
  );
}
