import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/generated/locales.g.dart';
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
        title: LocaleKeys.register.tr,
        appBarcolor: Get.theme.scaffoldBackgroundColor,
      ),
      body: MixinBuilder<SignUpWithEmailController>(
        builder: (controller) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Form(
                  key: controller.registerFormHelper.formKey,
                  autovalidateMode:
                      controller.registerFormHelper.autovalidateMode.value,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        Text(LocaleKeys.signup_subtitle.tr),
                        Column(
                          spacing: 24,
                          children: [
                            Column(
                              spacing: 12,
                              children: [
                                CustomFormField(
                                  label: LocaleKeys.name.tr,
                                  hintStyleColor: Colors.grey,
                                  hintText: LocaleKeys.enter_your_name.tr,
                                  controller: controller
                                      .registerFormHelper.controllers['name'],
                                  validator: controller
                                      .registerFormHelper.validators['name'],
                                  keyboardType: TextInputType.text,
                                ),
                                CustomFormField(
                                  label: LocaleKeys.email.tr,
                                  hintText: LocaleKeys.enter_your_email.tr,
                                  hintStyleColor: Colors.grey,
                                  controller: controller
                                      .registerFormHelper.controllers['email'],
                                  validator: controller
                                      .registerFormHelper.validators['email'],
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                CustomFormField(
                                  label: LocaleKeys.password.tr,
                                  isPassword: true,
                                  hintText: LocaleKeys.enter_your_password.tr,
                                  hintStyleColor: Colors.grey,
                                  controller: controller.registerFormHelper
                                      .controllers['password'],
                                  validator: controller.registerFormHelper
                                      .validators['password'],
                                  obscureText: true,
                                ),
                                CustomDateFormField(
                                  label: LocaleKeys.date_of_birth.tr,
                                  datehintstyle: Colors.grey,
                                  controller: controller.registerFormHelper
                                      .controllers['dateOfBirth'],
                                  validator: controller.registerFormHelper
                                      .validators['dateOfBirth'],
                                  readOnly: true,
                                  onTap: controller.selectDate,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Get.theme.primaryColor,
                                            width: 2,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: controller.acceptedTerms.value
                                            ? Center(
                                                child: Container(
                                                  width: 12,
                                                  height: 12,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        Get.theme.primaryColor,
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
                                            TextSpan(
                                                text: LocaleKeys
                                                    .terms_agreement.tr),
                                            TextSpan(
                                              text: LocaleKeys
                                                  .terms_and_conditions.tr,
                                              style: Get.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: Get.theme.primaryColor,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = Get.find<
                                                        AuthentificationController>()
                                                    .goToTermsAndConditions,
                                            ),
                                            const TextSpan(text: ' & '),
                                            TextSpan(
                                              text: LocaleKeys
                                                  .pp_view_privacy_policy.tr,
                                              style: Get.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: Get.theme.primaryColor,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = Get.find<
                                                        AuthentificationController>()
                                                    .goToPrivacyPolicy,
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
                            Column(
                              spacing: 10,
                              children: [
                                CustomButton(
                                  isLoading:
                                      controller.registerFormHelper.isLoading,
                                  text: LocaleKeys.register.tr,
                                  onPressed: !controller.acceptedTerms.value
                                      ? null
                                      : controller.registerFormHelper.submit,
                                ),
                                CustomButton(
                                  text: LocaleKeys.continue_button.tr,
                                  haveBorder: true,
                                  prefixIcon: const ImageComponent(
                                      assetPath: AppImages.google, width: 25),
                                  isLoading:
                                      Get.find<AuthentificationController>()
                                          .loadingGoogleSignup,
                                  onPressed:
                                      Get.find<AuthentificationController>()
                                          .googleSignup,
                                ),
                                CustomButton(
                                  text: 'Continue with Apple',
                                  haveBorder: true,
                                  prefixIcon: const Icon(Icons.apple,
                                      size: 25, color: Colors.black),
                                  isLoading:
                                      Get.find<AuthentificationController>()
                                          .loadingAppleSignup,
                                  onPressed:
                                      Get.find<AuthentificationController>()
                                          .appleSignup,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: Get.textTheme.bodySmall,
                                    children: [
                                      TextSpan(
                                          text: LocaleKeys
                                              .already_have_account.tr),
                                      TextSpan(
                                        text: LocaleKeys.sign_in_instead.tr,
                                        style:
                                            Get.textTheme.bodySmall?.copyWith(
                                          color: Get.theme.primaryColor,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = controller.goToLoginPage,
                                      ),
                                      const TextSpan(text: '.'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
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
