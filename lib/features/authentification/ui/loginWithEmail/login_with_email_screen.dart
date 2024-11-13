import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/features/authentification/ui/authentification/controllers/authentification_controller.dart';
import '../../../../core/ui/widgets/custom_button.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../core/utils/app_images.dart';
import 'controllers/login_with_email_controller.dart';
import 'package:get/get.dart';

class LoginWithEmailScreen extends GetView<LoginWithEmailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Sign In'),
      body: MixinBuilder<LoginWithEmailController>(
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
                            CustomFormField(
                              label: 'Email',
                              hintText: 'Enter your email',
                              controller: _.loginFormHelper.controllers['email'],
                              validator: _.loginFormHelper.validators['email'],
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20),
                            CustomFormField(
                              label: 'Password',
                              isPassword: true,
                              hintText: 'Enter your password',
                              controller: _.loginFormHelper.controllers['password'],
                              validator: _.loginFormHelper.validators['password'],
                              obscureText: true,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: Get.find<AuthentificationController>().navigateToForgotPassword,
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
                                  Text('Don\'t have an account?'),
                                  TextButton(
                                      onPressed: _.navigateToSignUp,
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
