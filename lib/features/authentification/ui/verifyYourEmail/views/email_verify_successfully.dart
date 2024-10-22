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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Expanded(
                  child: Center(
                child: ImageComponent(
                  assetPath: AppImages.logoWithName,
                  height: 400,
                ),
              )),
              const Center(
                child: Text(
                  'Email Verified\nSuccessfully',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: 'Continue',
                    onPressed: () {
                      Get.find<VerifyYourEmailController>().goToHome();
                    },
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
