import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
// import 'package:jappcare/features/workshop/ui/book_appointment/widgets/add_image_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/booking_widget.dart';
// import 'package:jappcare/features/workshop/ui/book_appointment/widgets/custom_map_widget.dart';
// import 'package:jappcare/features/workshop/ui/book_appointment/widgets/form_location_widget.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/service_widget.dart';
// import 'package:jappcare/features/garage/ui/garage/widgets/vehicle_list_widget.dart';
// import 'package:jappcare/features/workshop/ui/workshop/widgets/services_list_widget.dart';
// import 'package:jappcare/features/workshop/ui/workshop/widgets/service_center_services_list_widget.dart';

class BookAppointmentScreen extends GetView<BookAppointmentController> {
  final globalcontrollerWorkshop = Get.find<GlobalcontrollerWorkshop>();
  BookAppointmentScreen({super.key});

  // final GenerateVehiculeReportController generateVehiculeReportController = GenerateVehiculeReportController(Get.find());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Book Appointment',
          appBarcolor: Get.theme.scaffoldBackgroundColor,
          actions: [
            if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                  child: Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      if (Get.isRegistered<FeatureWidgetInterface>(
                          tag: 'ListVehicleWidget'))
                        Get.find<FeatureWidgetInterface>(
                                tag: 'ListVehicleWidget')
                            .buildView({
                          "pageController": controller.pageController,
                          "currentPage": controller.currentPage,
                          "haveAddVehicule": false,
                          "title": "Select Vehicle",
                          "viewCarDetailsOnCardPress": false,
                          "onSelected": (selectedCar) {
                            controller.vehicleId.value = selectedCar.id;
                            controller.vehicleVin.value = selectedCar.vin;
                            controller.globalControllerWorkshop
                                .addVehicle(selectedCar);
                            print(
                                "Current page: ${controller.currentPage.value}, Car ID: ${selectedCar.name}");
                          },
                        }),

                      // Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //     child: ServiceCenterServicesListWidget(
                      //       services: globalcontrollerWorkshop
                      //           .workshopData['centerServices'],
                      //       canSelect: false,
                      //     )),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select Service",
                                style: Get.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                child: controller
                                        .serviceCenterServices.isNotEmpty
                                    ? Obx(() {
                                        return ServiceWidget(
                                          tabs: controller.serviceCenterServices
                                              .map((e) => e.service)
                                              .toList(),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          selectedFilter: controller
                                              .selectedServiceIndex.value,
                                          haveBorder: true,
                                          onSelected: (index) {
                                            if (controller.selectedServiceIndex
                                                    .value ==
                                                index) {
                                              controller.selectedServiceIndex
                                                  .value = -1;
                                              controller.selectedServiceName
                                                  .value = '';
                                              controller.selectedServicePrice
                                                  .value = 0;
                                              controller
                                                  .selectedServiceId.value = '';
                                            } else {
                                              controller.selectedServiceName
                                                      .value =
                                                  controller
                                                      .serviceCenterServices[
                                                          index]
                                                      .service
                                                      .title;
                                              controller
                                                      .selectedServiceId.value =
                                                  controller
                                                      .serviceCenterServices[
                                                          index]
                                                      .service
                                                      .id;
                                              controller.selectedServicePrice
                                                  .value = controller
                                                      .serviceCenterServices[
                                                          index]
                                                      .price
                                                      ?.round() ??
                                                  0;
                                              controller.selectedServiceIndex
                                                  .value = index;
                                            }
                                          },
                                        );
                                      })
                                    : const Text('No services available'),
                              ),
                            ]),
                      ),

                      const BookingWidget(),
                      Obx(() {
                        return Column(
                          children: [
                            if (controller.selectedLocation.value ==
                                "HOME") ...[
                              const SizedBox(
                                height: 20,
                              ),
                              // CustomMapWidget(
                              //   latitude:
                              //       controller.placeDetails.value?.lat ?? 0,
                              //   longitude:
                              //       controller.placeDetails.value?.lng ?? 0,
                              //   placeName: controller.placeDetails.value?.name,
                              // ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: GoogleMap(
                                    mapType: MapType.normal,
                                    initialCameraPosition: controller.kYaounde,
                                    markers: controller.markers,
                                    onMapCreated: (GoogleMapController c) {
                                      if (!controller
                                          .mapController.isCompleted) {
                                        controller.mapController.complete(c);
                                      }
                                    },
                                    myLocationEnabled:
                                        true, // Shows the blue dot for current location
                                    myLocationButtonEnabled:
                                        false, // We use a custom button
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              // const FormLocationWidget(),
                            ],
                          ],
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CustomFormField(
                          controller: controller.noteController,
                          focusedBorderColor:
                              AppColors.greyText.withValues(alpha: .1),
                          filColor: AppColors.white,
                          maxLine: 7,
                          hintText: 'Add a Note (Optional)',
                        ),
                      ),

                      // const AddImageWidget(),
                      // EstimatedInspectionFee(),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: CustomButton(
                            text: 'Continue',
                            onPressed: () {
                              if (controller.formKey.currentState?.validate() ??
                                  false) {
                                controller.gotToConfirmAppointment();
                              } else {
                                Get.showCustomSnackBar(
                                    'Veuillez remplir tous les champs');
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              )),
              // Positioned(
              //     top: MediaQuery
              //         .of(context)
              //         .size
              //         .height * 0.7,
              //     right: 10,
              //     child: ChatWidget()
              // )
            ],
          ),
        ));
  }
}
