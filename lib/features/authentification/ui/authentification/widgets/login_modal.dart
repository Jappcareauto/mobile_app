import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/features/authentification/ui/authentification/controllers/authentification_controller.dart';

import '../../../../../core/utils/app_images.dart';

class LoginModalWidget extends StatelessWidget {
  const LoginModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthentificationController>();
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
            // height: 300,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 28,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 28),
                const Text("Login",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 28),
                CustomButton(
                    text: "Continue",
                    prefixIcon: const ImageComponent(
                      assetPath: AppImages.google,
                      height: 25,
                    ),
                    onPressed: () {
                      // _BottomSheetLogin();
                    }),
                const SizedBox(height: 16),
                CustomButton(
                    text: "Login with Email",
                    haveBorder: true,
                    onPressed: controller.goToLoginWithEmail),
                const SizedBox(height: 16),
                CustomButton(
                    text: "Login with Phone",
                    haveBorder: true,
                    onPressed: controller.goToLoginWithPhone),
              ],
            )),
      ),
    );
  }
}
