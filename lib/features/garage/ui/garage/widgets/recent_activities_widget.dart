import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/events/app_events_service.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/shimmers/list_vehicle_shimmer.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';

import '../../../../../core/ui/interfaces/feature_widget_interface.dart';
import '../../../../../core/ui/widgets/custom_tab_bar.dart';
import 'car_card_widget.dart';

class RecentActivitiesWidget extends StatefulWidget
    implements FeatureWidgetInterface {
  final String title;
  final String? noActivitiesPlaceholder;
  final String? vehicleId;
  final bool haveTitle;
  final bool haveTabBar;
  final bool isHorizontal;
  final String? status;
  final int? limit;

  const RecentActivitiesWidget({
    super.key,
    this.title = "Recent Activities",
    this.noActivitiesPlaceholder,
    this.haveTitle = true,
    this.haveTabBar = true,
    this.isHorizontal = false,
    this.status,
    this.vehicleId,
    this.limit,
  });

  @override
  State<RecentActivitiesWidget> createState() => _RecentActivitiesWidgetState();

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
        noActivitiesPlaceholder: args['noActivitiesPlaceholder'],
      );
    } else {
      return this;
    }
  }

  @override
  void refreshData() {
    final lastUserId =
        Get.find<AppEventService>().getLastValue(AppConstants.userIdEvent);
    final garageController = Get.find<GarageController>();
    if (lastUserId != null) {
      garageController.fetchData(lastUserId);
    }
  }
}

class _RecentActivitiesWidgetState extends State<RecentActivitiesWidget> {
  final GarageController garageController = Get.find<GarageController>();
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (garageController.appointmentsLoading.value) {
        return ListVehicleShimmer(
          isHorizontal: widget.isHorizontal,
        );
      }

      List<AppointmentEntity> filteredAppointments =
          List<AppointmentEntity>.from(garageController.appointments);
      filteredAppointments.sort(
          (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));

      // Logic for filtering
      String? filterStatus;
      if (widget.haveTabBar) {
        // Local state filtering
        if (_selectedTabIndex == 0) {
          filterStatus = null; // All
        } else if (_selectedTabIndex == 1) {
          filterStatus = "IN_PROGRESS"; // Ongoing
        } else if (_selectedTabIndex == 2) {
          filterStatus = "COMPLETED"; // Completed
        }
      } else {
        // Use prop status
        filterStatus = widget.status;
      }

      var filteredActivities = <CarCardWidget>[];

      if (garageController.appointments.isNotEmpty) {
        // Applying the filters locally
        filteredAppointments = filteredAppointments
            .where((e) => widget.vehicleId != null
                ? e.vehicle?.id == widget.vehicleId
                : true)
            .where(
                (e) => filterStatus != null ? e.status == filterStatus : true)
            .toList();

        filteredActivities = filteredAppointments.map((e) {
          final make = e.vehicle?.detail?.make;
          final model = e.vehicle?.detail?.model;
          final carName =
              [make, model].where((s) => s != null && s.isNotEmpty).join(' ');

          return CarCardWidget(
            latitude: e.location?.latitude ?? 0,
            longitude: e.location?.longitude ?? 0,
            date: DateFormat('MMM d, yyyy').format(DateTime.parse(e.date)),
            time: DateFormat('HH:mm').format(DateTime.parse(e.date)),
            localisation:
                e.locationType == "SERVICE_CENTER" ? "On Site" : e.locationType,
            nameCar: carName.isNotEmpty
                ? carName
                : (e.vehicle?.name ?? 'Unknown Vehicle'),
            pathImageCar: e.vehicle?.imageUrl ?? "",
            status: e.status ?? "Unknown",
            onPressed: () => garageController.goToAppointmentDetail(e),
            appointmentType:
                e.service?.title.replaceAll("_", " ").capitalizeFirst,
            serviceCenterName: e.serviceCenter?.name?.trim(),
          );
        }).toList();

        // Apply limit if provided
        filteredActivities = widget.limit != null
            ? widget.limit! > filteredActivities.length
                ? filteredActivities
                : filteredActivities.sublist(0, widget.limit!)
            : filteredActivities;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.haveTitle)
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                widget.title,
                style: Get.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          if (widget.haveTitle) const SizedBox(height: 15),
          if (widget.haveTabBar)
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: CustomTabBar(
                labels: garageController.statusFilters,
                selectedIndex: _selectedTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),
            ),
          if (widget.haveTabBar) const SizedBox(height: 20),
          if (filteredActivities.isNotEmpty)
            widget.isHorizontal
                ? SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: filteredActivities.map((activity) {
                        return SizedBox(
                          width: 350,
                          child: activity,
                        );
                      }).toList(),
                    ))
                : Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(children: filteredActivities),
                  ),

          // Empty state handling locally
          if (!garageController.appointmentsLoading.value &&
              filteredActivities.isEmpty)
            // Only show empty state if we really have no items after filter
            // And make sure it doesn't take full screen height if not needed
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                spacing: 20,
                children: [
                  Container(
                    height: 200, // Constrain height
                    decoration: BoxDecoration(
                      color: Get.theme.scaffoldBackgroundColor,
                    ),
                    child: Row(
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
                  ),
                  Text(
                    widget.noActivitiesPlaceholder ??
                        "You have no recent activities at the moment",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
        ],
      );
    });
  }
}
