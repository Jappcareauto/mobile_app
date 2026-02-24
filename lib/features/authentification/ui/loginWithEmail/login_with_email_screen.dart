import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/ui/widgets/image_decoration.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/features/authentification/ui/authentification/controllers/authentification_controller.dart';
import 'package:jappcare/generated/locales.g.dart';
import '../../../../core/ui/widgets/custom_button.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../core/utils/app_images.dart';
import 'controllers/login_with_email_controller.dart';
import 'package:get/get.dart';

class LoginWithEmailScreen extends GetView<LoginWithEmailController> {
  const LoginWithEmailScreen({super.key});

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
      body: MixinBuilder<LoginWithEmailController>(
        builder: (controller) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                          child:
                              ImageDecoration(assetPath: AppConstants.login)),
                      Column(
                        spacing: 16,
                        children: [
                          CustomFormField(
                            filColor: Colors.white,
                            label: LocaleKeys.email.tr,
                            hintText: 'e.g.michealjason@gmail.com',
                            hintStyleColor: Colors.grey,
                            focusedBorderColor: Get.theme.primaryColor,
                            controller:
                                controller.loginFormHelper.controllers['email'],
                            validator:
                                controller.loginFormHelper.validators['email'],
                            keyboardType: TextInputType.emailAddress,
                          ),
                          CustomFormField(
                            filColor: Colors.white,
                            hintStyleColor: Colors.grey,
                            focusedBorderColor: Get.theme.primaryColor,
                            label: LocaleKeys.password.tr,
                            isPassword: true,
                            hintText: LocaleKeys.password.tr,
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
                              onPressed: Get.find<AuthentificationController>()
                                  .navigateToForgotPassword,
                              child: Text(LocaleKeys.forgot_password.tr)),
                        ],
                      ),
                      Column(
                        spacing: 10,
                        children: [
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
                            onPressed: Get.find<AuthentificationController>()
                                .googleLogin,
                          ),
                          RichText(
                            text: TextSpan(
                              style: Get.textTheme.bodySmall,
                              children: [
                                TextSpan(text: LocaleKeys.dont_have_account.tr),
                                TextSpan(
                                  text: LocaleKeys.register.tr,
                                  style: Get.textTheme.bodySmall?.copyWith(
                                    color: Get.theme.primaryColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = controller.navigateToSignUp,
                                ),
                                const TextSpan(text: '.'),
                              ],
                            ),
                          ),
                        ],
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
