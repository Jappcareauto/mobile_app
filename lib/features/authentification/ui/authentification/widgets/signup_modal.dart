import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/generated/locales.g.dart';
import '../../../../../core/ui/widgets/custom_button.dart';
import '../../../../../core/ui/widgets/image_component.dart';
import '../../../../../core/utils/app_images.dart';
import '../controllers/authentification_controller.dart';

class SignUpModalWidget extends StatelessWidget {
  const SignUpModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthentificationController>();
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
            // height: 300,
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 14, bottom: 36),
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
                Text(LocaleKeys.create_account.tr,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 28),
                CustomButton(
                  text: LocaleKeys.continue_with_google.tr,
                  prefixIcon: const ImageComponent(
                    assetPath: AppImages.google,
                    height: 25,
                  ),
                  isLoading: controller.loadingGoogleSignup,
                  onPressed: controller.googleSignup,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: LocaleKeys.continue_with_apple.tr,
                  haveBorder: true,
                  prefixIcon:
                      const Icon(Icons.apple, size: 25, color: Colors.black),
                  isLoading: controller.loadingAppleSignup,
                  onPressed: controller.appleSignup,
                ),
                const SizedBox(height: 16),
                CustomButton(
                    text: LocaleKeys.create_account_with_email.tr,
                    haveBorder: true,
                    onPressed: controller.goToSignUpWithEmail),
                // const SizedBox(height: 16),
                // CustomButton(
                //     text: "Create Account with Phone",
                //     haveBorder: true,
                //     onPressed: controller.goToSignUpWithPhone),
              ],
            )),
      ),
    );
  }
}
