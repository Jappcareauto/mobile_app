import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/ui/widgets/image_decoration.dart';
import 'package:jappcare/core/ui/widgets/phone_form_field.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/features/authentification/ui/authentification/controllers/authentification_controller.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../core/utils/app_images.dart';
import 'controllers/login_with_phone_controller.dart';
import 'package:get/get.dart';

class LoginWithPhoneScreen extends GetView<LoginWithPhoneController> {
  const LoginWithPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Sign In'),
      body: MixinBuilder<LoginWithPhoneController>(
        builder: (controller) {
          return Padding(
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
                          child:
                              ImageDecoration(assetPath: AppConstants.singUp)),
                      Column(
                        spacing: 16,
                        children: [
                          CustomPhoneFormField(
                              label: 'Phone',
                              hintText: 'Enter your Phone',
                              controller: controller
                                  .loginFormHelper.controllers['phone'],
                              validator: controller
                                  .loginFormHelper.validators['phone']),
                          CustomFormField(
                            label: 'Password',
                            isPassword: true,
                            hintText: 'Enter your password',
                            controller: controller
                                .loginFormHelper.controllers['password'],
                            validator: controller
                                .loginFormHelper.validators['password'],
                            obscureText: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed:
                                      Get.find<AuthentificationController>()
                                          .navigateToForgotPassword,
                                  child: const Text('Forgot Password?')),
                            ],
                          ),
                          Column(spacing: 10, children: [
                            CustomButton(
                              isLoading: controller.loginFormHelper.isLoading,
                              text: 'Login',
                              onPressed: controller.loginFormHelper.submit,
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
                                      onPressed:
                                          controller.navigateToSignUpWithPhone,
                                      child: const Text('Register'))
                                ])
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
