import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/ui/widgets/phone_form_field.dart';
import 'package:jappcare/features/authentification/ui/authentification/controllers/authentification_controller.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../core/utils/app_images.dart';
import 'controllers/login_with_phone_controller.dart';
import 'package:get/get.dart';

class LoginWithPhoneScreen extends GetView<LoginWithPhoneController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Sign In'),
      body: MixinBuilder<LoginWithPhoneController>(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                key: _.loginFormHelper.formKey,
                autovalidateMode: _.loginFormHelper.autovalidateMode.value,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * .6,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            CustomPhoneFormField(
                                label: 'Phone',
                                hintText: 'Enter your Phone',
                                controller:
                                    _.loginFormHelper.controllers['phone'],
                                validator:
                                    _.loginFormHelper.validators['phone']),
                            const SizedBox(height: 20),
                            CustomFormField(
                              label: 'Password',
                              isPassword: true,
                              hintText: 'Enter your password',
                              controller:
                                  _.loginFormHelper.controllers['password'],
                              validator:
                                  _.loginFormHelper.validators['password'],
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .25,
                        child: Column(
                          children: [
                            CustomButton(
                              isLoading: _.loginFormHelper.isLoading,
                              text: 'Login',
                              onPressed: _.loginFormHelper.submit,
                            ),
                            const SizedBox(height: 20),
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
                                      onPressed: _.navigateToSignUpWithPhone,
                                      child: const Text('Register'))
                                ])
                          ],
                        ),
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
