import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/vehicle_card_widget.dart';
// import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirm_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/widgets/summary.dart';
// import 'package:jappcare/features/garage/ui/garage/widgets/vehicle_list_widget.dart';

class ConfirmeAppointmentScreen extends GetView<ConfirmAppointmentController> {
  // final BookAppointmentController bookAppointmentController = BookAppointmentController(Get.find());

  const ConfirmeAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appBarcolor: Get.theme.scaffoldBackgroundColor,
          title: 'Confirm\nAppointment',
          actions: [
            if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                spacing: 20,
                children: [
                  VehicleCardWidget(
                    haveBGColor: false,
                    haveBorder: true,
                    containerheight: 200,
                    carName: controller.globalControllerWorkshop
                            .workshopData['vehicle'].detail?.model ??
                        '',
                    carDetails: [
                      controller.globalControllerWorkshop
                              .workshopData['vehicle'].detail?.year ??
                          "Unknown",
                      controller.globalControllerWorkshop
                              .workshopData['vehicle'].detail?.make ??
                          "Unknown"
                    ],
                    imageUrl: controller.globalControllerWorkshop
                        .workshopData['vehicle'].imageUrl,
                  ),
                  Summary(),
                  CustomButton(
                    isLoading: controller.loading,
                    text: 'Book Appointment',
                    onPressed: () {
                      controller.booknewAppointment(
                        date: controller.globalControllerWorkshop
                            .workshopData['selectedDate'],
                        locationType: controller.globalControllerWorkshop
                            .workshopData['selectedLocation'],
                        note: controller.globalControllerWorkshop
                            .workshopData['noteController'],
                        serviceId: controller
                            .globalControllerWorkshop.workshopData['serviceId'],
                        vehicleId: controller.globalControllerWorkshop
                            .workshopData['vehicle'].id,
                        timeOfDay: controller.globalControllerWorkshop
                            .workshopData['selectedTime'],
                        serviceCenterId: controller.globalControllerWorkshop
                            .workshopData['serviceCenterId'],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
