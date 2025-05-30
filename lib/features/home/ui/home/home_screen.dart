import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/app_bar_with_salutation.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/features/home/ui/dashboard/controllers/dashboard_controller.dart';
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

  final DashboardController dashboardController =
      Get.find<DashboardController>();

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
          color: Get.theme.primaryColor,
          strokeWidth: 3.0,
          backgroundColor: AppColors.white,
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    spacing: 10,
                    children: [
                      if (controller.notifications.isNotEmpty) ...[
                        Column(
                          spacing: 10,
                          children: controller.notifications
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final notification = entry.value;

                            return Dismissible(
                              // key: Key(index.toString()),
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              background: const DismissWidget(),
                              onDismissed: (direction) {
                                // Action après la suppression
                                controller.notifications.removeAt(index);
                              },
                              child: NotificationWidget(
                                haveTitle: true,
                                textSize: 14,
                                backgrounColor: const Color(0xFFFFEDE6),
                                title: "Notification",
                                bodyText: notification,
                                coloriage: Get.theme.primaryColor,
                                icon: FluentIcons.alert_16_filled,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
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
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'ListVehicleWidget'))
                  Get.find<FeatureWidgetInterface>(tag: 'ListVehicleWidget')
                      .buildView({
                    "pageController": controller.pageController,
                    "currentPage": controller.currentPage,
                    "title": "My Garage",
                    'viewCarDetailsOnCardPress': true,
                    "onTapeAddVehicle": () {
                      print("clique");
                    },
                  }),
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'RecentActivitiesWidget')) ...[
                  Get.find<FeatureWidgetInterface>(
                          tag: 'RecentActivitiesWidget')
                      .buildView({
                    'haveTabBar': false,
                    'haveTitle': true,
                    'title': 'Upcoming Activities',
                    'status': 'NOT_STARTED',
                    'isHorizontal': true,
                    'limit': 1,
                    'noActivitiesPlaceholder':
                        'You have no upcoming activities at the moment'
                  }),
                ],

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
                                dashboardController.onItemTapped(2);
                                // controller.goToVehicleFinder();
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
                //RecentActivitiesWidget

                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'RecentActivitiesWidget'))
                  Get.find<FeatureWidgetInterface>(
                          tag: 'RecentActivitiesWidget')
                      .buildView(
                    {
                      'limit': 2,
                      'haveTabBar': false,
                      'haveTitle': true,
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
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
