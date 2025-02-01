import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/car_card_add_vehicle.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:jappcare/features/services/ui/generateVehiculeReport/controllers/generate_vehicule_report_controller.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/widgets/confirmation_appointment_modal.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/widgets/summary.dart';

class ConfirmeAppointmentScreen extends GetView<ConfirmeAppointmentController>{
  // final BookAppointmentController bookAppointmentController = BookAppointmentController(Get.find());
  final argument = Get.find<GlobalcontrollerWorkshop>().workshopData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Confirm\nAppointment',
          actions: [
            if (Get.isRegistered<FeatureWidgetInterface>(
                tag: 'AvatarWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget')
                  .buildView(),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'ListVehicleWidget'))
                  Get.find<FeatureWidgetInterface>(tag: 'ListVehicleWidget')
                      .buildView({
                    "pageController": controller.pageController ,
                    "currentPage": argument['currentPage'],
                    "haveAddVehicule": false,
                    "isSingleCard": true,
                    "title": "",
                    "onSelected": (index) {

                      print("Car Name: ${index}, Car ID: ${index}");
                    },
                  }),
                SizedBox(height: 20,),
                Summary(),
                SizedBox(height: 20,),

                Container(
                  // margin: EdgeInsets.symmetric(horizontal: ),
                  child: CustomButton(
                    isLoading: controller.loading,
                      text: 'Send Inspection Request',
                      onPressed: () {
                        print('send inspection');
                        controller.booknewAppointment(
                            argument['selectedDate'],
                            argument['selectedLocation'],
                            argument['noteController'],
                            argument['servciceId'],
                            argument['vehiculeId'],
                            "NOT_STARTED",
                            argument['selectedTime'],
                        );

                      }
                  ),
                ),
                SizedBox(height: 20,),

              ],
            ),
          ),


        )


    );
  }

}
