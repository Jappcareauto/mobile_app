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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Register'),
      body: MixinBuilder<SignUpWithEmailController>(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                key: _.registerFormHelper.formKey,
                autovalidateMode: _.registerFormHelper.autovalidateMode.value,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * .6,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            CustomFormField(
                              label: 'Name',
                              hintText: 'Enter your name',
                              controller:
                                  _.registerFormHelper.controllers['name'],
                              validator:
                                  _.registerFormHelper.validators['name'],
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(height: 20),
                            CustomFormField(
                              label: 'Email',
                              hintText: 'Enter your email',
                              controller:
                                  _.registerFormHelper.controllers['email'],
                              validator:
                                  _.registerFormHelper.validators['email'],
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20),
                            CustomFormField(
                              label: 'Password',
                              isPassword: true,
                              hintText: 'Enter your password',
                              controller:
                                  _.registerFormHelper.controllers['password'],
                              validator:
                                  _.registerFormHelper.validators['password'],
                              obscureText: true,
                            ),
                            const SizedBox(height: 8),
                            CustomDateFormField(
                              label: 'Date of Birth',
                              controller: _.registerFormHelper
                                  .controllers['dateOfBirth'],
                              validator: _
                                  .registerFormHelper.validators['dateOfBirth'],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Radio(
                                    value: true,
                                    groupValue: true,
                                    onChanged: (a) {}),
                                Expanded(
                                  child: Text(
                                    "By continuing, you agree to our ",
                                    style: Get.textTheme.bodySmall,
                                  ),
                                ),
                                TextButton(
                                    onPressed: Get.find<AuthentificationController>().goToTermsAndConditions,
                                    child: Text(
                                      'Terms and Conditions',
                                      style: Get.textTheme.bodySmall?.copyWith(
                                          color: Get.theme.primaryColor),
                                    )),
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
                              isLoading: _.registerFormHelper.isLoading,
                              text: 'Register',
                              onPressed: _.registerFormHelper.submit,
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
                                      onPressed: _.goToLoginPage,
                                      child: const Text('Login'))
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
