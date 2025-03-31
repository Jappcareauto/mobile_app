import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import '../../../../core/ui/widgets/custom_app_bar.dart';
import '../../../../core/ui/widgets/custom_button.dart';
import '../../../../core/ui/widgets/custom_date_form_filed.dart';
import '../../../../core/ui/widgets/image_component.dart';
import '../../../../core/utils/app_images.dart';
import '../authentification/controllers/authentification_controller.dart';
import 'controllers/sign_up_with_email_controller.dart';
import 'package:get/get.dart';

class SignUpWithEmailScreen extends GetView<SignUpWithEmailController> {
  const SignUpWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Register',
        appBarcolor: Get.theme.scaffoldBackgroundColor,
      ),
      body: MixinBuilder<SignUpWithEmailController>(
        builder: (controller) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Form(
                  key: controller.registerFormHelper.formKey,
                  autovalidateMode:
                      controller.registerFormHelper.autovalidateMode.value,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                            'Hey there! Sign up with your email to get started'),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            CustomFormField(
                              label: 'Name',
                              hintStyleColor: Colors.grey,
                              hintText: 'Enter your name',
                              controller: controller
                                  .registerFormHelper.controllers['name'],
                              validator: controller
                                  .registerFormHelper.validators['name'],
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(height: 20),
                            CustomFormField(
                              label: 'Email',
                              hintText: 'Enter your email',
                              hintStyleColor: Colors.grey,
                              controller: controller
                                  .registerFormHelper.controllers['email'],
                              validator: controller
                                  .registerFormHelper.validators['email'],
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20),
                            CustomFormField(
                              label: 'Password',
                              isPassword: true,
                              hintText: 'Enter your password',
                              hintStyleColor: Colors.grey,
                              controller: controller
                                  .registerFormHelper.controllers['password'],
                              validator: controller
                                  .registerFormHelper.validators['password'],
                              obscureText: true,
                            ),
                            const SizedBox(height: 8),
                            CustomDateFormField(
                              label: 'Date of Birth',
                              datehintstyle: Colors.grey,
                              controller: controller.registerFormHelper
                                  .controllers['dateOfBirth'],
                              validator: controller
                                  .registerFormHelper.validators['dateOfBirth'],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Checkbox(
                                //   tristate: true,
                                //   value: controller.acceptedTerms.value,
                                //   onChanged: (bool? value) {
                                //     print("clicked");
                                //     print(value);
                                //     if (value == null) {
                                //       controller
                                //           .acceptTermsAndConditions(false);
                                //     } else {
                                //       controller
                                //           .acceptTermsAndConditions(value);
                                //     }
                                //   },
                                //   shape: const CircleBorder(),
                                // ),
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
                                        color: const Color(0xFFFB7C37),
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
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFFFB7C37),
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
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
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            CustomButton(
                              isLoading:
                                  controller.registerFormHelper.isLoading,
                              text: 'Register',
                              onPressed: controller.registerFormHelper.submit,
                            ),
                            const SizedBox(height: 10),
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
                            const SizedBox(height: 10),
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
            ),
          );
        },
      ),
    );
  }
}
