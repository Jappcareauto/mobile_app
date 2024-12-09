import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';
class ConfirmationAppointmentModal extends GetView<ConfirmeAppointmentController> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(


          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:[
              Container(
                height: 150,
                child: ImageComponent(
                  assetPath: AppImages.processChat,
                )
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                'Appointment request sent',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Subtitle
              const Text(
                'Your appointment request has been sent.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel button
                  CustomButton(
                      strech: false,
                      width: 170,

                      haveBorder: true,
                      text: 'Cancel',
                      onPressed: (){
                        Get.back();
                      }),
                  // Proceed to Chat button
                  CustomButton(
                    strech: false,

                      width: 170,
                      text: 'Proceed to Chat',
                      onPressed: (){
                            controller.goToChat();
                         }
                  )
                ],
              ),
            ],
          ),
        ),
      );

  }
}