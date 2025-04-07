import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/widgets/summary.dart';

class ConfirmeAppointmentScreen extends GetView<ConfirmeAppointmentController> {
  // final BookAppointmentController bookAppointmentController = BookAppointmentController(Get.find());
  final argument = Get.find<GlobalcontrollerWorkshop>().workshopData;

  ConfirmeAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Confirm\nAppointment',
          actions: [
            if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'ListVehicleWidget'))
                  Get.find<FeatureWidgetInterface>(tag: 'ListVehicleWidget')
                      .buildView({
                    "pageController": controller.pageController,
                    "currentPage": argument['currentPage'],
                    "haveAddVehicule": false,
                    "isSingleCard": true,
                    "title": "",
                    "onSelected": (index) {
                      print("Car Name: $index, Car ID: $index");
                    },
                  }),
                const SizedBox(
                  height: 20,
                ),
                Summary(),
                const SizedBox(
                  height: 20,
                ),

                // margin: EdgeInsets.symmetric(horizontal: ),
                CustomButton(
                    isLoading: controller.loading,
                    text: 'Send Inspection Request',
                    onPressed: () {
                      print('send inspection');
                      controller.booknewAppointment(
                        argument['selectedDate'],
                        argument['selectedLocation'],
                        argument['noteController'],
                        argument['serviceId'],
                        argument['vehiculeId'],
                        "NOT_STARTED",
                        argument['selectedTime'],
                      );
                    }),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
