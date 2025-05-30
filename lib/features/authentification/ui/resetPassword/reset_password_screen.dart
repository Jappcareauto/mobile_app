import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'controllers/reset_password_controller.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Reset Password",
        appBarcolor: Get.theme.scaffoldBackgroundColor,
      ),
      body: MixinBuilder<ResetPasswordController>(
        builder: (controller) {
          final form = controller.index.value == 0
              ? controller.forgotPasswordFormHelper
              : controller.index.value == 1
                  ? controller.formHelper
                  : controller.resetPasswordFormHelper;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: form.formKey,
                autovalidateMode: form.autovalidateMode.value,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 36,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        spacing: 20,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (controller.index.value == 1) ...[
                            // CustomFormField(
                            //   label: 'Code',
                            //   hintText: 'Enter receive by email',
                            //   controller: form.controllers['code'],
                            //   validator: form.validators['code'],
                            //   keyboardType: TextInputType.emailAddress,
                            // ),
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
                                      "We've sent a code to the email ",
                                      style: Get.textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold),
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
                                          color:
                                              Color.fromRGBO(30, 60, 87, 0.3)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  // onCompleted: (value) =>
                                  //     form.submit,
                                  // androidSmsAutofillMethod:
                                  //     AndroidSmsAutofillMethod.none,
                                  controller: form.controllers['code'],
                                  validator: form.validators['code'],
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
                                            style: Get.textTheme.bodyMedium
                                                ?.copyWith(
                                              color: Get.theme.primaryColor,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {},
                                          ),
                                          const TextSpan(text: '.'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                          if (controller.index.value == 2)
                            CustomFormField(
                              label: 'Password',
                              isPassword: true,
                              hintText: 'Enter new password',
                              controller: form.controllers['newPassword'],
                              validator: form.validators['newPassword'],
                              obscureText: true,
                            ),
                          if (controller.index.value == 0)
                            CustomFormField(
                              label: 'Email',
                              hintText: 'Enter your email',
                              controller: form.controllers['email'],
                              validator: form.validators['email'],
                              keyboardType: TextInputType.emailAddress,
                            ),
                        ],
                      ),
                      CustomButton(
                        isLoading: form.isLoading,
                        text: 'Continue',
                        onPressed: form.submit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
