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
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        SizedBox(
                          height: Get.height * .6,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
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
                                controller: controller.registerFormHelper
                                    .controllers['dateOfBirth'],
                                validator: controller.registerFormHelper
                                    .validators['dateOfBirth'],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Radio(
                                      value: true,
                                      groupValue: true,
                                      onChanged: (a) {}),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: Expanded(
                                      child: Text(
                                        "By continuing, you agree to our ",
                                        style: Get.textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed:
                                        Get.find<AuthentificationController>()
                                            .goToTermsAndConditions,
                                    child: Text(
                                      'Terms and Conditions',
                                      style: Get.textTheme.bodySmall?.copyWith(
                                          color: Get.theme.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .24,
                          child: Column(
                            children: [
                              CustomButton(
                                isLoading:
                                    controller.registerFormHelper.isLoading,
                                text: 'Register',
                                onPressed: controller.registerFormHelper.submit,
                              ),
                              const SizedBox(height: 20),
                              CustomButton(
                                text: 'Continue',
                                haveBorder: true,
                                prefixIcon: const ImageComponent(
                                    assetPath: AppImages.google, width: 25),
                                isLoading:
                                    Get.find<AuthentificationController>()
                                        .loadingGoogle,
                                onPressed:
                                    Get.find<AuthentificationController>()
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
