import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/ui/widgets/custom_button.dart';
import '../../../../../core/ui/widgets/image_component.dart';
import '../../../../../core/utils/app_images.dart';
import '../controllers/authentification_controller.dart';

class SignUpModalWidget extends StatelessWidget {
  const SignUpModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthentificationController>();
    return Container(
        height: 300,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Register",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            CustomButton(
                text: "Continue",
                prefixIcon: const ImageComponent(
                  assetPath: AppImages.google,
                  height: 25,
                ),
                onPressed: () {
                  // _BottomSheetLogin();
                }),
            const SizedBox(height: 20),
            CustomButton(
                text: "Create Account with Email",
                haveBorder: true,
                onPressed: controller.goToSignUpWithEmail),
            const SizedBox(height: 20),
            CustomButton(
                text: "Create Account with Phone",
                haveBorder: true,
                onPressed: controller.goToSignUpWithPhone),
          ],
        ));
  }
}
