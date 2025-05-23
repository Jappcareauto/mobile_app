import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
// import 'package:jappcare/core/ui/widgets/image_decoration.dart';
// import 'package:jappcare/core/utils/app_constants.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/utils/app_images.dart';
import 'controllers/verify_your_email_controller.dart';
import 'package:get/get.dart';

class VerifyYourEmailScreen extends GetView<VerifyYourEmailController> {
  const VerifyYourEmailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        canBack: true,
        title: "Verify Your\nEmail",
        appBarcolor: Get.theme.scaffoldBackgroundColor,
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'Having issues?',
              ))
        ],
      ),
      body: GetBuilder<VerifyYourEmailController>(
        initState: (_) {},
        builder: (controller) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: controller.verifyEmailFormHelper.formKey,
                autovalidateMode:
                    controller.verifyEmailFormHelper.autovalidateMode.value,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 36,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        spacing: 20,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: ImageComponent(
                                assetPath: AppImages.mail, width: 150),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // const ImageDecoration(
                              //     assetPath: AppConstants.sms),
                              Text(
                                "We've sent a verification email to ",
                                style: Get.textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                controller.email,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Get.theme.primaryColor),
                              ),
                            ],
                          ),
                          Pinput(
                            length: 6,
                            keyboardType: TextInputType.text,
                            defaultPinTheme: PinTheme(
                              width: 60,
                              height: 52,
                              textStyle: const TextStyle(
                                  fontSize: 25,
                                  color: Color.fromRGBO(30, 60, 87, 1),
                                  fontWeight: FontWeight.w600),
                              decoration: BoxDecoration(
                                color: Get.theme.scaffoldBackgroundColor,
                                border: Border.all(
                                    color: Color.fromRGBO(30, 60, 87, 0.3)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onCompleted: (value) =>
                                controller.verifyEmailFormHelper.submit,
                            // androidSmsAutofillMethod:
                            //     AndroidSmsAutofillMethod.none,
                            controller: controller
                                .verifyEmailFormHelper.controllers['code'],
                            validator: controller
                                .verifyEmailFormHelper.validators['code'],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: Get.textTheme.bodyMedium,
                                  children: [
                                    const TextSpan(
                                        text: 'Didn\'t get the code? '),
                                    TextSpan(
                                      text: 'Resend it',
                                      style: Get.textTheme.bodyMedium?.copyWith(
                                        color: Get.theme.primaryColor,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = controller.resendOtp,
                                    ),
                                    const TextSpan(text: '.'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      CustomButton(
                        text: 'Continue',
                        isLoading: controller.verifyEmailFormHelper.isLoading,
                        // onPressed: controller.verifyEmailFormHelper.submit,
                        onPressed: controller.goToVerificationSuccess,
                      ),
                    ],
                  ),
                ),
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: SingleChildScrollView(
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Column(
                //               children: [
                //                 const Padding(
                //                   padding: EdgeInsets.symmetric(horizontal: 40),
                //                   child: ImageComponent(
                //                       assetPath: AppImages.mail, width: 150),
                //                 ),
                //                 const SizedBox(height: 20),
                //                 Column(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: [
                //                     // const ImageDecoration(
                //                     //     assetPath: AppConstants.sms),
                //                     Text(
                //                       "We've sent a verification email to ",
                //                       style: Get.textTheme.bodyLarge?.copyWith(
                //                           fontWeight: FontWeight.bold),
                //                     ),
                //                     Text(
                //                       controller.email,
                //                       style: TextStyle(
                //                           fontSize: 16,
                //                           fontWeight: FontWeight.bold,
                //                           color: Get.theme.primaryColor),
                //                     ),
                //                   ],
                //                 ),
                //                 const SizedBox(height: 20),
                //                 Pinput(
                //                   length: 6,
                //                   keyboardType: TextInputType.text,
                //                   defaultPinTheme: PinTheme(
                //                     width: 60,
                //                     height: 60,
                //                     textStyle: const TextStyle(
                //                         fontSize: 25,
                //                         color: Color.fromRGBO(30, 60, 87, 1),
                //                         fontWeight: FontWeight.w600),
                //                     decoration: BoxDecoration(
                //                       color: Get.theme.primaryColor
                //                           .withValues(alpha: 0.1),
                //                       borderRadius: BorderRadius.circular(10),
                //                     ),
                //                   ),
                //                   onCompleted: (value) =>
                //                       controller.verifyEmailFormHelper.submit,
                //                   // androidSmsAutofillMethod:
                //                   //     AndroidSmsAutofillMethod.none,
                //                   controller: controller.verifyEmailFormHelper
                //                       .controllers['code'],
                //                   validator: controller
                //                       .verifyEmailFormHelper.validators['code'],
                //                 ),
                //                 const SizedBox(height: 5),
                //                 Row(
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   children: [
                //                     const Text("Didn't get the code?"),
                //                     TextButton(
                //                       onPressed: controller.resendOtp,
                //                       child: const Text(
                //                         "Resend it",
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     CustomButton(
                //       text: 'Continue',
                //       isLoading: controller.verifyEmailFormHelper.isLoading,
                //       onPressed: controller.verifyEmailFormHelper.submit,
                //     ),
                //   ],
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}
