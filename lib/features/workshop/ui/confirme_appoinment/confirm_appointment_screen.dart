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
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/widgets/confirmation_appointment_modal.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/widgets/summary.dart';

class ConfirmeAppointmentScreen extends GetView<ConfirmeAppointmentController>{
  final BookAppointmentController bookAppointmentController = BookAppointmentController(Get.find());
  final argument  = Get.arguments['currentPge'];
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
                    "pageController": bookAppointmentController.pageController ,
                    "currentPage": argument,
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
                            bookAppointmentController.selectedDate.value,
                            bookAppointmentController.selectedLocation.value ,
                            bookAppointmentController.noteController.text ,
                            // Get.arguments['servicesId'],
                            "a814b1b3-ed82-4854-94ad-8a58898ca2fc",// ce services ID sera remplacer lorsque l'api de recupereation des service seras interger
                            bookAppointmentController.vehicleId.value,
                            "NOT_STARTED",
                            bookAppointmentController.selectedTime.value
                        );
                        if(controller.requestIsSend.value) {
                          onpenModalConfirmMethod();
                        }
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
void onpenModalConfirmMethod() {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true, // Permet un contrôle précis sur la hauteur
    backgroundColor: Colors.transparent, // Rendre l'arrière-plan transparent
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16), // Espacement intérieur
          child: Wrap(
            children: [
              ConfirmationAppointmentModal()
            ],
          ),
        ),
      );
    },
  );
}
