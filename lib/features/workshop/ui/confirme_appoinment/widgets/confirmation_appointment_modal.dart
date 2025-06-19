import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';

class ConfirmationAppointmentModal
    extends GetView<ConfirmeAppointmentController> {
  const ConfirmationAppointmentModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
                height: 150,
                child: ImageComponent(
                  assetPath: AppImages.processChat,
                )),
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
            // const Text(
            //   'Your appointment request has been sent.',
            //   style: TextStyle(
            //     fontSize: 14.0,
            //     color: Colors.black54,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel button
                Expanded(
                  child: CustomButton(
                      strech: false,
                      haveBorder: true,
                      text: 'Cancel',
                      onPressed: controller.goToHome),
                ),
                // Proceed to Chat button
                CustomButton(
                    strech: false,
                    text: 'Proceed to Chat',
                    isLoading: controller.proceedChatLoading,
                    onPressed: () => controller.goToChatScreen())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
