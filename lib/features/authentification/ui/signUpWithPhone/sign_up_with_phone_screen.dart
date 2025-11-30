import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
// import 'package:jappcare/core/ui/widgets/phone_form_field.dart';
import 'package:jappcare/core/utils/app_dimensions.dart';
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
          return SafeArea(
            child: Padding(
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
                            // CustomPhoneFormField(
                            //   label: 'Phone',
                            //   hintText: 'Enter your phone',
                            //   controller: controller
                            //       .registerFormHelper.controllers['phone'],
                            //   validator: controller
                            //       .registerFormHelper.validators['phone'],
                            //   onCountryChange: (value) {
                            //     if (value.dialCode != null) {
                            //       controller
                            //           .registerFormHelper
                            //           .controllers['code']
                            //           ?.text = value.dialCode!;
                            //     }
                            //   },
                            //   onChanged: (value) {
                            //     controller.registerFormHelper
                            //         .controllers["phone"]?.text = value;
                            //   },
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Text(
                                  "Phone",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.black),
                                ),
                                // const SizedBox(height: 8),
                                IntlPhoneField(
                                  controller: controller
                                      .registerFormHelper.controllers['phone'],
                                  validator: (phoneNumber) {
                                    final validator = controller.registerFormHelper.validators['phone'];
                                    print('phone: $phoneNumber, validator: ${phoneNumber?.number}');
                                    return validator != null
                                        ? validator(phoneNumber?.number)
                                        : null;
                                  },
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  decoration: InputDecoration(
                                    hintText: 'Ex. 655002200',
                                    fillColor: Colors.white,
                                    filled: true,
                                    errorStyle: const TextStyle(color: Color(0XFFFF553B)),
                                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions.radiusSmall),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions.radiusSmall),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFE5E2E1)),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions.radiusSmall),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions.radiusSmall),
                                      borderSide: BorderSide(
                                          color: Get.theme.primaryColor),
                                    ),
                                  ),
                                  initialCountryCode:
                                      'CM', // Set a default country code, e.g., for Cameroon
                                  onChanged: (phone) {
                                    // You can get the full phone number with country code here
                                    print(phone.completeNumber);
                                    controller.phoneCode.value = phone.countryCode;
                                  },
                                ),
                              ],
                            ),
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
                              controller: controller.registerFormHelper
                                  .controllers['dateOfBirth'],
                              validator: controller
                                  .registerFormHelper.validators['dateOfBirth'],
                              readOnly: true,
                              onTap: controller.selectDate,
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
                              isLoading:
                                  controller.registerFormHelper.isLoading,
                              text: 'Register',
                              onPressed: controller.registerFormHelper.submit,
                            ),
                            CustomButton(
                              text: 'Continue',
                              haveBorder: true,
                              prefixIcon: const ImageComponent(
                                  assetPath: AppImages.google, width: 25),
                              isLoading: Get.find<AuthentificationController>()
                                  .loadingGoogleSignup,
                              onPressed: Get.find<AuthentificationController>()
                                  .googleSignup,
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
            ),
          );
        },
      ),
    );
  }
}
