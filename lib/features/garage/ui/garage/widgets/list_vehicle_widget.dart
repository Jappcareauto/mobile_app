import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/events/app_events_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import '../../../../../core/ui/interfaces/feature_widget_interface.dart';
import 'car_card_add_vehicle.dart';
import 'shimmers/garage_name_shimmer.dart';
import 'shimmers/list_vehicle_shimmer.dart';

class ListVehicleWidget extends StatelessWidget
    implements FeatureWidgetInterface {
  final GarageController garageController =
      GarageController(Get.find(), Get.find());
  final bool haveTitle;
  final PageController? pageController;
  final RxInt? currentPage;
  final bool? haveAddVehicule;
  final String title;
  final VoidCallback? onTapeAddVehicle;
  final bool? isSingleCard;
  final Function(Vehicle selectCar)? onSelected;
  final int? selectedIndex;

  ListVehicleWidget({
    super.key,
    this.pageController,
    this.currentPage,
    this.haveAddVehicule = true,
    this.onTapeAddVehicle,
    this.isSingleCard,
    this.haveTitle = true,
    this.title = "My Garage",
    this.onSelected,
    this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<GarageController>(
      init: GarageController(Get.find(), Get.find()),
      autoRemove: false,
      builder: (controller) {
        if (controller.vehicleLoading.value) {
          return const ListVehicleShimmer();
        }

        print(
            'controller.vehicleList.length : ${controller.vehicleList.length}');

        final vehiclesToDisplay = controller.vehicleList.isEmpty
            ? []
            : isSingleCard == true
                ? [
                    controller.vehicleList[(currentPage?.value ?? 0)
                        .clamp(0, controller.vehicleList.length - 1)]
                  ]
                : controller.vehicleList;

        // Initialiser l'appel de `onSelected` pour le premier élément
        WidgetsBinding.instance.addPostFrameCallback((controller) {
          if (vehiclesToDisplay.isNotEmpty &&
              onSelected != null &&
              currentPage?.value == 0) {
            onSelected!(vehiclesToDisplay[0]);
          }
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (haveTitle)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() {
                  return controller.loading.value
                      ? const MyGarageNameShimmer()
                      : Text(
                          title,
                          style: Get.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        );
                }),
              ),
            if (haveTitle) const SizedBox(height: 5),
            SizedBox(
              height: 190,
              child: PageView.builder(
                controller: pageController,
                itemCount: vehiclesToDisplay.length +
                    (haveAddVehicule == true ? 1 : 0),
                onPageChanged: (index) {
                  currentPage?.value = index;
                  if (index < vehiclesToDisplay.length && onSelected != null) {
                    onSelected!(vehiclesToDisplay[index]);
                  }
                },
                itemBuilder: (context, index) {
                  if (haveAddVehicule == true &&
                      index == vehiclesToDisplay.length) {
                    return GestureDetector(
                      onTap: controller.goToAddVehicle,
                      child: Container(
                        height: 200,
                        // margin: const EdgeInsets.only(right: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Get.theme.primaryColor.withValues(alpha: .1),
                          border: Border.all(
                            color: Get.theme.primaryColor.withValues(alpha: .1),
                            width: 3,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            '+ Add Vehicle',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    );
                  }

                  var vehicle = vehiclesToDisplay[index];
                  // final  interiorMedia = vehicle.media.firstWhere(
                  //       (media) => media.type == "INTERIOR",
                  //   orElse: () => vehicle.media.isNotEmpty ? vehicle.media.first : null,
                  // );
                  return CarCardAddVehicle(
                    key: ValueKey(vehicle),
                    haveBGColor: false,
                    hideblure: true,
                    haveBorder: currentPage?.value == index,
                    containerheight: 200,
                    next: () {
                      controller.goToVehicleDetails(vehicle);
                      // if (index == (vehiclesToDisplay.length - 1) && !haveAddVehicule!) {
                      //   pageController?.jumpToPage(0);
                      // } else {
                      //   pageController?.nextPage(
                      //     duration: const Duration(milliseconds: 300),
                      //     curve: Curves.easeInOut,
                      //   );
                      // }
                    },
                    carName: vehicle.detail?.model ?? '',
                    carDetails: [
                      vehicle.detail?.year ?? "Unknown",
                      vehicle.detail?.make ?? "Unknown"
                    ],
                    imagePath: vehicle.media?[2]?.sourceUrl ?? '',
                    imageUrl: vehicle.media?[2]?.sourceUrl ?? '',
                  );
                },
              ),
            )
          ],
        );
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
    return ListVehicleWidget(
      pageController: args["pageController"],
      currentPage: args["currentPage"],
      haveAddVehicule: args["haveAddVehicule"],
      onTapeAddVehicle: args["onTapeAddVehicle"],
      title: args["title"],
      isSingleCard: args["isSingleCard"],
      onSelected: args["onSelected"],
    );
  }
}
