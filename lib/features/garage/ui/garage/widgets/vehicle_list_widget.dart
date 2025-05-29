// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'car_card_add_vehicle.dart';
import 'shimmers/list_vehicle_shimmer.dart';

class VehicleListWidget extends StatelessWidget {
  // final GarageController garageController =
  //     GarageController(Get.find(), Get.find());

  late RxBool vehiclesLoading;
  late RxList<Vehicle> vehicles;
  final bool haveTitlePadding;
  final PageController? pageController;
  final RxInt? currentPage;
  final String? title;
  final VoidCallback? onTapAddVehicle;
  final Function(Vehicle vehicle)? onTapViewVehicle;
  final Function(Vehicle vehicle)? onTapDeleteVehicle;
  final bool? isSingleCard;
  final Function(Vehicle vehicle)? onSelected;
  final int? selectedIndex;

  VehicleListWidget({
    super.key,
    required this.vehiclesLoading,
    required this.vehicles,
    this.pageController,
    this.currentPage,
    this.onTapAddVehicle,
    this.onTapViewVehicle,
    this.onTapDeleteVehicle,
    this.isSingleCard,
    this.haveTitlePadding = true,
    this.title = "My Garage",
    this.onSelected,
    this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (vehiclesLoading.value) return const ListVehicleShimmer();

      final RxList<Vehicle> vehiclesToDisplay = RxList<Vehicle>(vehicles.isEmpty
          ? []
          : isSingleCard == true
              ? [
                  vehicles[
                      (currentPage?.value ?? 0).clamp(0, vehicles.length - 1)]
                ]
              : vehicles);

      // // Initialiser l'appel de `onSelected` pour le premier élément
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
          if (title != null)
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: haveTitlePadding ? 20 : 0),
              child: Text(
                title!,
                style: Get.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (title != null) const SizedBox(height: 10),
          SizedBox(
              height: 190,
              child: PageView.builder(
                controller: pageController,
                itemCount: vehiclesToDisplay.length +
                    (onTapAddVehicle != null ? 1 : 0),
                onPageChanged: (index) {
                  currentPage?.value = index;
                  if (index < vehiclesToDisplay.length && onSelected != null) {
                    onSelected!(vehiclesToDisplay[index]);
                  }
                },
                itemBuilder: (context, index) {
                  if (onTapAddVehicle != null &&
                      index == vehiclesToDisplay.length) {
                    return GestureDetector(
                      onTap: onTapAddVehicle,
                      child: Container(
                        height: 200,
                        // margin: const EdgeInsets.only(right: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white,
                          border: Border.all(
                            color: Get.theme.primaryColor,
                            width: 1.3,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '+ Add Vehicle',
                            style: TextStyle(
                                color: Get.theme.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
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
                    showDelete: onTapDeleteVehicle != null,
                    haveBorder: currentPage?.value == index ? true : false,
                    containerheight: 200,
                    onPressed: () => onTapViewVehicle?.call(vehicle),
                    next: vehiclesToDisplay.length > 1
                        ? () {
                            if (index == (vehiclesToDisplay.length - 1) &&
                                onTapAddVehicle == null) {
                              pageController?.jumpToPage(0);
                            } else {
                              pageController?.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          }
                        : null,
                    delete: () => onTapDeleteVehicle?.call(vehicle),
                    carName: vehicle.detail?.model ?? '',
                    carDetails: [
                      vehicle.detail?.year ?? "Unknown",
                      vehicle.detail?.make ?? "Unknown"
                    ],
                    imagePath:
                        vehicle.media != null && vehicle.media!.isNotEmpty
                            ? vehicle.media![0]?.sourceUrl ?? ""
                            : '',
                    imageUrl: vehicle.imageUrl,
                  );
                },
              ))
        ],
      );
    });

    //  MixinBuilder<GarageController>(
    //   init: GarageController(Get.find(), Get.find()),
    //   autoRemove: false,
    //   builder: (controller) {
    //     if (vehiclesLoading.value) {
    //       return const ListVehicleShimmer();
    //     }

    //     final RxList<Vehicle> vehiclesToDisplay =
    //         RxList<Vehicle>(vehicles.isEmpty
    //             ? []
    //             : isSingleCard == true
    //                 ? [
    //                     vehicles[(currentPage?.value ?? 0)
    //                         .clamp(0, controller.vehicleList.length - 1)]
    //                   ]
    //                 : controller.vehicleList);

    //     // Initialiser l'appel de `onSelected` pour le premier élément
    //     WidgetsBinding.instance.addPostFrameCallback((controller) {
    //       if (vehiclesToDisplay.isNotEmpty &&
    //           onSelected != null &&
    //           currentPage?.value == 0) {
    //         onSelected!(vehiclesToDisplay[0]);
    //       }
    //     });

    //     return Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         if (haveTitle)
    //           Padding(
    //             padding:
    //                 EdgeInsets.symmetric(horizontal: haveTitlePadding ? 20 : 0),
    //             child: Obx(() {
    //               return controller.loading.value
    //                   ? const MyGarageNameShimmer()
    //                   : Text(
    //                       title,
    //                       style: Get.textTheme.bodyLarge?.copyWith(
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     );
    //             }),
    //           ),
    //         if (haveTitle) const SizedBox(height: 10),
    //         SizedBox(
    //             height: 190,
    //             child: PageView.builder(
    //               controller: pageController,
    //               itemCount: vehiclesToDisplay.length +
    //                   (haveAddVehicule == true ? 1 : 0),
    //               onPageChanged: (index) {
    //                 currentPage?.value = index;
    //                 if (index < vehiclesToDisplay.length &&
    //                     onSelected != null) {
    //                   onSelected!(vehiclesToDisplay[index]);
    //                 }
    //               },
    //               itemBuilder: (context, index) {
    //                 if (haveAddVehicule == true &&
    //                     index == vehiclesToDisplay.length) {
    //                   return GestureDetector(
    //                     onTap: controller.goToAddVehicle,
    //                     child: Container(
    //                       height: 200,
    //                       // margin: const EdgeInsets.only(right: 12),
    //                       width: double.infinity,
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(24),
    //                         color: Colors.white,
    //                         border: Border.all(
    //                           color: Get.theme.primaryColor,
    //                           width: 1.3,
    //                         ),
    //                       ),
    //                       child: Center(
    //                         child: Text(
    //                           '+ Add Vehicle',
    //                           style: TextStyle(
    //                               color: Get.theme.primaryColor,
    //                               fontSize: 16,
    //                               fontWeight: FontWeight.w400),
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 }

    //                 var vehicle = vehiclesToDisplay[index];
    //                 // final  interiorMedia = vehicle.media.firstWhere(
    //                 //       (media) => media.type == "INTERIOR",
    //                 //   orElse: () => vehicle.media.isNotEmpty ? vehicle.media.first : null,
    //                 // );
    //                 return Obx(() {
    //                   return CarCardAddVehicle(
    //                     key: ValueKey(vehicle),
    //                     haveBGColor: false,
    //                     hideblure: true,
    //                     showDelete: showDelete,
    //                     haveBorder: currentPage?.value == index ? true : false,
    //                     containerheight: 200,
    //                     onPressed: () {
    //                       print(viewCarDetailsOnCardPress);
    //                       if (viewCarDetailsOnCardPress == true) {
    //                         controller.goToVehicleDetails(vehicle);
    //                       }
    //                     },
    //                     next: vehiclesToDisplay.length > 1
    //                         ? () {
    //                             if (index == (vehiclesToDisplay.length - 1) &&
    //                                 !haveAddVehicule!) {
    //                               pageController?.jumpToPage(0);
    //                             } else {
    //                               pageController?.nextPage(
    //                                 duration: const Duration(milliseconds: 300),
    //                                 curve: Curves.easeInOut,
    //                               );
    //                             }
    //                           }
    //                         : null,
    //                     delete: () {
    //                       controller.openDeleteVehicle(vehicle);
    //                     },
    //                     carName: vehicle.detail?.model ?? '',
    //                     carDetails: [
    //                       vehicle.detail?.year ?? "Unknown",
    //                       vehicle.detail?.make ?? "Unknown"
    //                     ],
    //                     imagePath:
    //                         vehicle.media != null && vehicle.media!.isNotEmpty
    //                             ? vehicle.media![0]?.sourceUrl ?? ""
    //                             : '',
    //                     imageUrl: vehicle.imageUrl,
    //                   );
    //                 });
    //               },
    //             ))
    //       ],
    //     );
    //   },
    // );
  }
}
