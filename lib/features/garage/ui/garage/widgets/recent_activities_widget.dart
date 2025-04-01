import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/events/app_events_service.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';

import '../../../../../core/ui/interfaces/feature_widget_interface.dart';
import '../../../../../core/ui/widgets/custom_tab_bar.dart';
import 'car_card_widget.dart';

class RecentActivitiesWidget extends StatelessWidget
    implements FeatureWidgetInterface {
  final GarageController garageController =
      GarageController(Get.find(), Get.find());

  final String title;
  final String? noActivitiesPlaceholder;
  final bool haveTitle;
  final bool haveTabBar;
  final bool isHorizontal;
  final String? status;
  RecentActivitiesWidget(
      {super.key,
      this.title = "Recent Activities",
      this.noActivitiesPlaceholder,
      this.haveTitle = true,
      this.haveTabBar = true,
      this.isHorizontal = false,
      this.status});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GarageController>(
      init: GarageController(Get.find(), Get.find()),
      autoRemove: false,
      initState: (_) {},
      builder: (controller) {
        var filteredActivities = <CarCardWidget>[];

        if (controller.vehicleList.isNotEmpty &&
            controller.myGarage?.location != null) {
          filteredActivities = controller.vehicleList
              .map(
                (e) => CarCardWidget(
                  latitude: controller.myGarage!.location!.latitude,
                  longitude: controller.myGarage!.location!.longitude,
                  date:
                      "${DateTime.parse(controller.myGarage!.location!.createdAt).year}/${DateTime.parse(controller.myGarage!.location!.createdAt).month.toString().padLeft(2, '0')}/${DateTime.parse(controller.myGarage!.location!.createdAt).day.toString()..toString().padLeft(2, '0')}",
                  time:
                      "${DateTime.parse(controller.myGarage!.location!.createdAt).hour.toString().padLeft(2, '0')}:${DateTime.parse(controller.myGarage!.location!.createdAt).minute.toString().padLeft(2, '0')}:${DateTime.parse(controller.myGarage!.location!.createdAt).second.toString().padLeft(2, '0')}",
                  localisation:
                      controller.myGarage!.location!.latitude.toString(),
                  nameCar: e.name,
                  pathImageCar: e.imageUrl,
                  status: 'Completed',
                  onPressed: () => controller.goToAppointmentDetail(e),
                ),
              )
              .toList();
          if (status != null) {
            filteredActivities =
                filteredActivities.where((w) => w.status == status).toList();
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (haveTitle)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  title,
                  style: Get.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            if (haveTitle) const SizedBox(height: 15),
            if (haveTabBar)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CustomTabBar(
                  labels: const ["All", "Ongoing", "Completed"],
                  onTabSelected: (index) {},
                ),
              ),
            if (haveTabBar) const SizedBox(height: 20),
            filteredActivities.isNotEmpty
                ? isHorizontal
                    ? SizedBox(
                        height: 230,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: filteredActivities.map((activity) {
                            return SizedBox(
                              width:
                                  330, // Specify a fixed width for each item.
                              // margin: const EdgeInsets.all(8.0),
                              child: activity,
                            );
                          }).toList(),
                        ))
                    : Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(children: filteredActivities),
                      )
                : Column(
                    spacing: 20,
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: ImageComponent(
                              assetPath: AppConstants.noActivities,
                              height: 200,
                              width: double.infinity,
                            ),
                          ),
                        ],
                      ),
                      Text(noActivitiesPlaceholder ??
                          "You have no recent activities at the moment"),
                    ],
                  )
          ],
        );
        // if (controller.myGarage?.location == null ||
        //     controller.vehicleList.isEmpty) {
        //   if (title == "Recent Activities") {
        //     return const Center(
        //       child: Column(
        //         children: [
        //           Row(
        //             children: [
        //               Expanded(
        //                 child: ImageComponent(
        //                   assetPath: AppConstants.noActivities,
        //                   height: 200,
        //                   width: double.infinity,
        //                 ),
        //               ),
        //             ],
        //           ),
        //           SizedBox(
        //             height: 20,
        //           ),
        //           Text('You have no recent activities at the moment'),
        //           SizedBox(
        //             height: 20,
        //           ),
        //         ],
        //       ),
        //     );
        //   } else {
        //     return const SizedBox();
        //   }
        // }

        // return controller.vehicleList.isEmpty
        //     ? const SizedBox()
        //     :
      },
    );
  }

  @override
  void refreshData() {
    final lastUserId =
        Get.find<AppEventService>().getLastValue(AppConstants.userIdEvent);
    if (lastUserId != null) {
      garageController.fetchData(lastUserId);
    }
  }

  @override
  Widget buildView([args]) {
    if (args != null && args is bool) {
      return RecentActivitiesWidget(haveTabBar: args);
    } else if (args != null && args is String) {
      return RecentActivitiesWidget(
        title: args,
      );
    } else if (args != null && args is Map) {
      return RecentActivitiesWidget(
          haveTabBar: args['haveTabBar'] ?? true,
          haveTitle: args['haveTitle'] ?? true,
          title: args['title'] ?? 'Recent Activities',
          isHorizontal: args['isHorizontal'] ?? false,
          status: args['status'],
          noActivitiesPlaceholder: args['noActivitiesPlaceholder']);
    } else {
      return this;
    }
  }
}
