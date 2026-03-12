import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/ui/widgets/image_decoration.dart';
// import 'package:jappcare/core/ui/widgets/phone_form_field.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/app_dimensions.dart';
import 'package:jappcare/features/authentification/ui/authentification/controllers/authentification_controller.dart';
import 'package:jappcare/generated/locales.g.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../core/utils/app_images.dart';
import 'controllers/login_with_phone_controller.dart';
import 'package:get/get.dart';

class LoginWithPhoneScreen extends GetView<LoginWithPhoneController> {
  const LoginWithPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarcolor: Get.theme.scaffoldBackgroundColor,
        title: LocaleKeys.sign_in.tr,
        actions: [
          TextButton(
              onPressed: () => {}, child: Text(LocaleKeys.having_issues.tr))
        ],
      ),
      body: MixinBuilder<LoginWithPhoneController>(
        builder: (controller) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Form(
                  key: controller.loginFormHelper.formKey,
                  autovalidateMode:
                      controller.loginFormHelper.autovalidateMode.value,
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 10,
                      children: [
                        const SizedBox(
                            width: 210,
                            height: 200,
                            child: ImageDecoration(
                                assetPath: AppConstants.singUp)),
                        Column(
                          spacing: 16,
                          children: [
                            // CustomPhoneFormField(
                            //   label: 'Phone',
                            //   hintText: 'Enter your Phone',
                            //   controller:
                            //       controller.loginFormHelper.controllers['phone'],
                            //   validator:
                            //       controller.loginFormHelper.validators['phone'],
                            //   onCountryChange: (value) {
                            //     if (value.dialCode != null) {
                            //       controller.loginFormHelper.controllers['code']
                            //           ?.text = value.dialCode!;
                            //     }
                            //   },
                            //   onChanged: (value) {
                            //     controller.loginFormHelper.controllers["phone"]
                            //         ?.text = value;
                            //   },
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Text(
                                  LocaleKeys.phone_number.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.black),
                                ),
                                // const SizedBox(height: 8),
                                IntlPhoneField(
                                  controller: controller
                                      .loginFormHelper.controllers['phone'],
                                  validator: (phoneNumber) {
                                    final validator = controller
                                        .loginFormHelper.validators['phone'];
                                    print(
                                        'phone: $phoneNumber, validator: ${phoneNumber?.number}');
                                    return validator != null
                                        ? validator(phoneNumber?.number)
                                        : null;
                                  },
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  decoration: InputDecoration(
                                    hintText: 'Ex. 655002200',
                                    fillColor: Colors.white,
                                    filled: true,
                                    errorStyle: const TextStyle(
                                        color: Color(0XFFFF553B)),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.grey),
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
                                    controller.phoneCode.value =
                                        phone.countryCode;
                                  },
                                ),
                              ],
                            ),
                            CustomFormField(
                              label: LocaleKeys.password.tr,
                              isPassword: true,
                              hintText: LocaleKeys.enter_your_password.tr,
                              controller: controller
                                  .loginFormHelper.controllers['password'],
                              validator: controller
                                  .loginFormHelper.validators['password'],
                              obscureText: true,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed:
                                    Get.find<AuthentificationController>()
                                        .navigateToForgotPassword,
                                child: Text(LocaleKeys.forgot_password.tr)),
                          ],
                        ),
                        Column(spacing: 16, children: [
                          CustomButton(
                            isLoading: controller.loginFormHelper.isLoading,
                            text: LocaleKeys.login.tr,
                            onPressed: controller.loginFormHelper.submit,
                          ),
                          CustomButton(
                            text: LocaleKeys.continue_button.tr,
                            haveBorder: true,
                            prefixIcon: const ImageComponent(
                                assetPath: AppImages.google, width: 25),
                            isLoading: Get.find<AuthentificationController>()
                                .loadingGoogle,
                            onPressed: null,
                          ),
                          CustomButton(
                            text: 'Continue with Apple',
                            haveBorder: true,
                            prefixIcon: const Icon(Icons.apple,
                                size: 25, color: Colors.black),
                            isLoading: Get.find<AuthentificationController>()
                                .loadingApple,
                            onPressed: Get.find<AuthentificationController>()
                                .appleLogin,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(LocaleKeys.dont_have_account.tr),
                                TextButton(
                                    onPressed:
                                        controller.navigateToSignUpWithPhone,
                                    child: Text(LocaleKeys.register.tr))
                              ])
                        ])
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
