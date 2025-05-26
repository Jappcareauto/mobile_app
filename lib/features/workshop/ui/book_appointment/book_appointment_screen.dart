import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/add_image_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/boocking_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/custom_map_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/form_location_widget.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/service_widget.dart';
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
                              const Text(
                                "Select Service",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                child: controller.centerServices.isNotEmpty
                                    ? Obx(() {
                                        return ServiceWidget(
                                          tabs: controller.centerServices,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          selectedFilter: controller
                                              .selectedServiceIndex.value,
                                          onSelected: (index) {
                                            if (controller.selectedServiceIndex
                                                    .value ==
                                                index) {
                                              controller.selectedServiceIndex
                                                  .value = -1;
                                              controller.selectedServiceName
                                                  .value = '';
                                              controller
                                                  .selectedServiceId.value = '';
                                            } else {
                                              controller.selectedServiceName
                                                      .value =
                                                  controller
                                                      .centerServices[index]
                                                      .title;
                                              controller
                                                      .selectedServiceId.value =
                                                  controller
                                                      .centerServices[index].id;
                                              controller.selectedServiceIndex
                                                  .value = index;
                                            }
                                          },
                                        );
                                      })
                                    : const Text('Aucun service disponible'),
                              ),
                            ]),
                      ),

                      const BookingWidget(),
                      Obx(() {
                        return Column(
                          children: [
                            if (controller.selectedLocation.value == "CUSTOM" ||
                                controller.selectedLocation.value ==
                                    "HOME") ...[
                              const SizedBox(
                                height: 20,
                              ),
                              CustomMapWidget(),
                              const SizedBox(
                                height: 10,
                              ),
                              const FormLocationWidget(),
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

                      const AddImageWidget(),
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
