import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/car_card_add_vehicle.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/widgets/summary.dart';

class ConfirmeAppointmentScreen extends GetView<ConfirmeAppointmentController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Confirm Appointment'),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CarCardAddVehicle(
                  haveBGColor: false,
                    containerheight: 200,
                    haveBorder: false,
                    hideblure: true,
                    carName: 'Porsche Taycan Turbo S',
                    carDetails: '2024 , RWD',
                    imagePath: AppImages.carWhite
                ),
                SizedBox(height: 20,),
                Summary(),
                SizedBox(height: 20,),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                      text: 'Send Inspection Request',
                      onPressed: () {
                        print('send inspection');
                        controller.openModal();
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