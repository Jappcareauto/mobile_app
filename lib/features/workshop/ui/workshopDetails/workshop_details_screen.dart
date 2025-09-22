import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/vehicle_list_widget.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/map_controller.dart';
// import 'package:jappcare/features/workshop/ui/workshop/controllers/workshop_controller.dart';
// import 'package:jappcare/features/workshop/ui/workshop/widgets/service_center_services_list_widget.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/service_widget.dart';
import 'package:jappcare/features/workshop/ui/workshopDetails/views/workshop_custom_map_view.dart';
import 'package:jappcare/features/workshop/ui/workshopDetails/widgets/text_shimmer.dart';
import '../widgets/workshop_carrousel.dart';
import 'controllers/workshop_details_controller.dart';
import 'package:get/get.dart';

class WorkshopDetailsScreen extends GetView<WorkshopDetailsController> {
  final MapController garageController = Get.put(MapController(Get.find()));
  final globalcontrollerWorkshop = Get.find<GlobalcontrollerWorkshop>();
  // final WorkshopController workshopController = WorkshopController(Get.find());

  WorkshopDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const ImageCarousel(
                      positionIndicator: MainAxisAlignment.center,
                      imageUrls: [
                        AppImages.shopCar,
                        AppImages.carWhite,
                        AppImages.shopCar
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 45, left: 20),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 5,
                      children: [
                        Expanded(
                          child: Text(
                            globalcontrollerWorkshop
                                .workshopData['serviceCenterName'],
                            style: Get.textTheme.headlineMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            // softWrap: false,
                          ),
                        ),
                        Chip(
                          backgroundColor: globalcontrollerWorkshop
                                  .workshopData["availability"]
                              ? const Color(0xFFC4FFCD)
                              : const Color.fromARGB(255, 255, 187, 196),
                          label: Text(
                            globalcontrollerWorkshop
                                    .workshopData["availability"]
                                ? 'Available'
                                : "Not Available",
                            style: TextStyle(
                                color: globalcontrollerWorkshop
                                        .workshopData["availability"]
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w600),
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0,
                                color: globalcontrollerWorkshop
                                        .workshopData["availability"]
                                    ? const Color(0xFFC4FFCD)
                                    : const Color.fromARGB(255, 231, 109, 125)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.place_rounded,
                                color: Get.theme.primaryColor,
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Obx(() => controller.loading.value
                                    ? const TextShimmer()
                                    : Text(
                                        globalcontrollerWorkshop
                                                .workshopData["locationName"] ??
                                            "Unknown",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Get.theme.primaryColor,
                                        ),
                                      )),
                              )
                            ],
                          ),
                        ),
                        
                            const Row(
                              children: [
                                Icon(Icons.star_rounded,
                                    color: Colors
                                        .orange), // Utiliser une couleur appropriée
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  globalcontrollerWorkshop.workshopData['description'],
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Specialized Services",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Obx(() {
                        return SizedBox(
                          child: controller.serviceCenterServicesLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              :
                          
                          controller.serviceCenterServices.isNotEmpty
                              ? ServiceWidget(
                                  tabs: controller.serviceCenterServices
                                      .map((e) => e.service)
                                      .toList(),
                                  borderRadius: BorderRadius.circular(16),
                                  haveBorder: true,
                                )
                              : const Text('Aucun service disponible'),
                        );
                      }),
                    ]),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                  height: 300,
                  child: Row(
                    children: [
                      WorkshopCustomMapView(),
                    ],
                  )),
              // const SizedBox(height: 20),
              // VehicleListWidget(
              //   vehiclesLoading: false.obs,
              //   vehicles: controller.vehicles,
              //   pageController: controller.pageController,
              //   currentPage: controller.currentPage,
              //   onTapAddVehicle: controller.garageController.goToAddVehicle,
              //   onTapViewVehicle:
              //       controller.garageController.goToVehicleDetails,
              // ),
              
              const SizedBox(height: 20),
              Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => CustomButton(
                    text: 'Book Appointment',
                    onPressed: controller.serviceCenterServices.isNotEmpty
                        ? () {
                            controller.gotoBookAppointment();
                          }
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
