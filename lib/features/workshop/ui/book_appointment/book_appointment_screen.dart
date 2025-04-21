import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/add_image_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/boocking_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/custom_map_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/form_location_widget.dart';
// import 'package:jappcare/features/workshop/ui/workshop/widgets/services_list_widget.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/service_center_services_list_widget.dart';

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
                child: Column(
                  spacing: 20,
                  children: [
                    const SizedBox(
                      height: 1,
                    ),
                    if (Get.isRegistered<FeatureWidgetInterface>(
                        tag: 'ListVehicleWidget'))
                      Get.find<FeatureWidgetInterface>(tag: 'ListVehicleWidget')
                          .buildView({
                        "pageController": controller.pageController,
                        "currentPage": controller.currentPage,
                        "haveAddVehicule": false,
                        "title": "Select Vehicle",
                        "onSelected": (selectedCar) {
                          controller.vehicleId.value = selectedCar.id;
                          controller.vehicleVin.value = selectedCar.vin;
                          controller.globalControllerWorkshop
                              .addVehicle(selectedCar);
                          print(
                              "Current page: ${controller.currentPage.value}, Car ID: ${selectedCar.name}");
                        },
                      }),

                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ServiceCenterServicesListWidget(
                          services: globalcontrollerWorkshop
                              .workshopData['centerServices'],
                          canSelect: false,
                        )),

                    const BookingWidget(),
                    CustomMapWidget(),
                    const FormLocationWidget(),

                    const AddImageWidget(),
                    // EstimatedInspectionFee(),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomButton(
                          text: 'Continue',
                          onPressed: () {
                            if (controller.formKey.currentState?.validate() ??
                                false) {
                              controller.gotToConfirmAppointment();
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
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
