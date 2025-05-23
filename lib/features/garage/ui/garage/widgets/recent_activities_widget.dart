import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/events/app_events_service.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/shimmers/list_vehicle_shimmer.dart';

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
  final int? limit;
  RecentActivitiesWidget(
      {super.key,
      this.title = "Recent Activities",
      this.noActivitiesPlaceholder,
      this.haveTitle = true,
      this.haveTabBar = true,
      this.isHorizontal = false,
      this.status,
      this.limit});

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<GarageController>(
      init: GarageController(Get.find(), Get.find()),
      autoRemove: false,
      builder: (controller) {
        var filteredActivities = <CarCardWidget>[];

        if (controller.appointments.isNotEmpty &&
            controller.myGarage?.location != null) {
          var limitedActivities = limit != null
              ? controller.appointments.sublist(0, limit!)
              : controller.appointments;

          filteredActivities = limitedActivities.map((e) {
            return CarCardWidget(
              latitude: e.location?.latitude ??
                  controller.myGarage!.location!.latitude,
              longitude: e.location?.longitude ??
                  controller.myGarage!.location!.longitude,
              date:
                  "${DateTime.parse(e.date).year}/${DateTime.parse(e.date).month.toString().padLeft(2, '0')}/${DateTime.parse(e.date).day.toString().padLeft(2, '0')}",
              time:
                  "${DateTime.parse(e.date).hour.toString().padLeft(2, '0')}:${DateTime.parse(e.date).minute.toString().padLeft(2, '0')}:${DateTime.parse(e.date).second.toString().padLeft(2, '0')}",
              localisation: e.locationType,
              nameCar: e.vehicle?.name ?? "Unknown",
              pathImageCar: e.vehicle?.imageUrl,
              status: e.status ?? "Unknown",
              onPressed: () => controller.goToAppointmentDetail(e),
            );
          }).toList();
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
                  labels: controller.statusFilters,
                  onTabSelected: (index) {
                    if (controller.statusFilters[index] == "All") {
                      controller.selectedAppointStatusFilter.value = "";
                    } else if (controller.statusFilters[index] == "Ongoing") {
                      controller.selectedAppointStatusFilter.value =
                          "IN_PROGRESS";
                    } else if (controller.statusFilters[index] == "Completed") {
                      controller.selectedAppointStatusFilter.value =
                          "COMPLETED";
                    }
                  },
                ),
              ),
            if (haveTabBar) const SizedBox(height: 20),
            if (controller.appointmentsLoading.value)
              ListVehicleShimmer(
                isHorizontal: isHorizontal,
              ),
            if (!controller.appointmentsLoading.value &&
                filteredActivities.isNotEmpty)
              isHorizontal
                  ? SizedBox(
                      height: 230,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: filteredActivities.map((activity) {
                          return SizedBox(
                            width: 350, // Specify a fixed width for each item.
                            // margin: const EdgeInsets.all(8.0),
                            child: activity,
                          );
                        }).toList(),
                        // const SizedBox(width: 10),
                      ))
                  : Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(children: filteredActivities),
                    ),
            if (!controller.appointmentsLoading.value &&
                filteredActivities.isEmpty)
              Column(
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
          limit: args['limit'],
          noActivitiesPlaceholder: args['noActivitiesPlaceholder']);
    } else {
      return this;
    }
  }
}
