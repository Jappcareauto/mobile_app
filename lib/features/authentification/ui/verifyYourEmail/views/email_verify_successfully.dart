import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/features/authentification/ui/verifyYourEmail/controllers/verify_your_email_controller.dart';

import '../../../../../core/utils/app_images.dart';

class SuccessVerifiedMailScreen extends StatefulWidget {
  const SuccessVerifiedMailScreen({super.key});

  @override
  State<SuccessVerifiedMailScreen> createState() =>
      _SuccessVerifiedMailScreenState();
}

class _SuccessVerifiedMailScreenState extends State<SuccessVerifiedMailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 32,
                  children: [
                    Center(
                      child: ImageComponent(
                          assetPath: AppImages.successVerify,
                          width: Get.context!.width * .7),
                    ),
                    Center(
                      child: Text(
                        'Email Verified\nSuccessfully',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize:
                                Get.theme.textTheme.displaySmall!.fontSize,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: 'Continue',
                // onPressed: () {
                //   Get.find<VerifyYourEmailController>().goToHome();
                // },
                onPressed: () {
                  Get.find<VerifyYourEmailController>().goToLogin();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
