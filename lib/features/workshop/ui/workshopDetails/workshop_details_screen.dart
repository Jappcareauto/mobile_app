import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
// import 'package:jappcare/features/workshop/ui/workshop/controllers/workshop_controller.dart';
// import 'package:jappcare/features/workshop/ui/workshop/widgets/service_center_services_list_widget.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/service_widget.dart';
import 'package:jappcare/features/workshop/ui/workshopDetails/views/workshop_custom_map_view.dart';
import 'package:jappcare/features/workshop/ui/workshopDetails/widgets/text_shimmer.dart';
import '../widgets/workshop_carrousel.dart';
import 'controllers/workshop_details_controller.dart';
import 'package:get/get.dart';

class WorkshopDetailsScreen extends GetView<WorkshopDetailsController> {
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
                                Icons.place_outlined,
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
                        Row(
                          children: [
                            Text(
                              '|',
                              style: TextStyle(
                                  fontSize: 20, color: Get.theme.primaryColor),
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
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        child: controller.serviceCenterServices.value != null &&
                                controller.serviceCenterServices.value!.data
                                    .isNotEmpty
                            ? ServiceWidget(
                                tabs: controller
                                    .serviceCenterServices.value!.data,
                                borderRadius: BorderRadius.circular(16),
                                haveBorder: true,
                              )
                            : const Text('Aucun service disponible'),
                      ),

                      // SizedBox(
                      //   child: globalcontrollerWorkshop
                      //                   .workshopData['centerServices'] !=
                      //               null &&
                      //           globalcontrollerWorkshop
                      //               .workshopData['centerServices']!.isNotEmpty
                      //       ? ServiceWidget(
                      //           tabs: (globalcontrollerWorkshop
                      //                   .workshopData['centerServices']
                      //               as List<ServiceEntity>),
                      //           borderRadius: BorderRadius.circular(16),
                      //         )
                      //       : const Text('Aucun service disponible'),
                      // ),
                    ]),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 20.0),
              //   child: Column(
              //       spacing: 20,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const Text(
              //           "Specialized Services",
              //           style: TextStyle(
              //               fontSize: 18, fontWeight: FontWeight.bold),
              //         ),
              //         SizedBox(
              //           child: globalcontrollerWorkshop
              //                           .workshopData['centerServices'] !=
              //                       null &&
              //                   globalcontrollerWorkshop
              //                       .workshopData['centerServices']!.isNotEmpty
              //               ? ServiceWidget(
              //                   tabs: (globalcontrollerWorkshop
              //                           .workshopData['centerServices']
              //                       as List<ServiceEntity>),
              //                   borderRadius: BorderRadius.circular(16),
              //                 )
              //               : const Text('Aucun service disponible'),
              //         ),
              //       ]),
              // ),
              const SizedBox(height: 20),
              const SizedBox(
                  height: 300,
                  child: Row(
                    children: [
                      WorkshopCustomMapView(),
                    ],
                  )),
              const SizedBox(height: 20),
              Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  text: 'Book Appointment',
                  onPressed: () {
                    controller.gotoBookAppointment();
                  },
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
