import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/ui/widgets/phone_form_field.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/authentification/ui/authentification/controllers/authentification_controller.dart';
import '../../../../core/ui/widgets/custom_button.dart';
import '../../../../core/ui/widgets/custom_date_form_filed.dart';
import 'controllers/sign_up_with_phone_controller.dart';
import 'package:get/get.dart';

class SignUpWithPhoneScreen extends GetView<SignUpWithPhoneController> {
  const SignUpWithPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Register',
        appBarcolor: Get.theme.scaffoldBackgroundColor,
      ),
      body: MixinBuilder<SignUpWithPhoneController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                key: controller.registerFormHelper.formKey,
                autovalidateMode:
                    controller.registerFormHelper.autovalidateMode.value,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          'Hey there! Sign up with phone number. We will send your verification code there.'),
                      Column(
                        spacing: 20,
                        children: [
                          CustomFormField(
                            label: 'Name',
                            hintText: 'Enter your name',
                            controller: controller
                                .registerFormHelper.controllers['name'],
                            validator: controller
                                .registerFormHelper.validators['name'],
                            keyboardType: TextInputType.text,
                          ),
                          CustomPhoneFormField(
                              label: 'Phone',
                              hintText: 'Enter your phone',
                              controller: controller
                                  .registerFormHelper.controllers['phone'],
                              validator: controller
                                  .registerFormHelper.validators['phone']),
                          CustomFormField(
                            label: 'Password',
                            isPassword: true,
                            hintText: 'Enter your password',
                            controller: controller
                                .registerFormHelper.controllers['password'],
                            validator: controller
                                .registerFormHelper.validators['password'],
                            obscureText: true,
                          ),
                          CustomDateFormField(
                            label: 'Date of Birth',
                            controller: controller
                                .registerFormHelper.controllers['dateOfBirth'],
                            validator: controller
                                .registerFormHelper.validators['dateOfBirth'],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    controller.acceptTermsAndConditions(
                                        !controller.acceptedTerms.value),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  // Outer circle: orange border, white background
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Get.theme.primaryColor,
                                      width: 2,
                                    ),
                                    color: Colors.white,
                                  ),
                                  // If checked, show a smaller orange dot in the center
                                  child: controller.acceptedTerms.value
                                      ? Center(
                                          child: Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Get.theme.primaryColor,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                              ),
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                    style: Get.textTheme.bodySmall,
                                    children: [
                                      const TextSpan(
                                          text:
                                              'By continuing, you agree to our '),
                                      TextSpan(
                                        text: 'Terms & Conditions',
                                        style:
                                            Get.textTheme.bodySmall?.copyWith(
                                          color: Get.theme.primaryColor,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = Get.find<
                                                  AuthentificationController>()
                                              .goToTermsAndConditions,
                                      ),
                                      const TextSpan(text: '.'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        spacing: 10,
                        children: [
                          CustomButton(
                            isLoading: controller.registerFormHelper.isLoading,
                            text: 'Register',
                            onPressed: controller.registerFormHelper.submit,
                          ),
                          CustomButton(
                            text: 'Continue',
                            haveBorder: true,
                            prefixIcon: const ImageComponent(
                                assetPath: AppImages.google, width: 25),
                            isLoading: Get.find<AuthentificationController>()
                                .loadingGoogle,
                            onPressed: Get.find<AuthentificationController>()
                                .loginWithGoogle,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an account?'),
                                TextButton(
                                    onPressed: controller.goToLoginPage,
                                    child: const Text('Login'))
                              ])
                        ],
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
