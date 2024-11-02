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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      Center(
                        child: ImageComponent(
                            assetPath: AppImages.successVerify,
                            width: Get.context!.width * .8),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          'Email Verified\nSuccessfully',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              )),
              CustomButton(
                text: 'Continue',
                onPressed: () {
                  Get.find<VerifyYourEmailController>().goToHome();
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
