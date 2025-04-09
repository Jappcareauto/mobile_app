import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'controllers/reset_password_controller.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Reset Password",
        appBarcolor: Get.theme.scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: MixinBuilder<ResetPasswordController>(
          builder: (controller) {
            final form = controller.index.value == 0
                ? controller.forgotPasswordFormHelper
                : controller.index.value == 1
                    ? controller.formHelper
                    : controller.resetPasswordFormHelper;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                  key: form.formKey,
                  autovalidateMode: form.autovalidateMode.value,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      if (controller.index.value == 1)
                        CustomFormField(
                          label: 'Code',
                          hintText: 'Enter receive by email',
                          controller: form.controllers['code'],
                          validator: form.validators['code'],
                          keyboardType: TextInputType.emailAddress,
                        ),
                      if (controller.index.value == 2)
                        CustomFormField(
                          label: 'Password',
                          isPassword: true,
                          hintText: 'Enter new password',
                          controller: form.controllers['newPassword'],
                          validator: form.validators['newPassword'],
                          obscureText: true,
                        ),
                      if (controller.index.value == 0)
                        CustomFormField(
                          label: 'Email',
                          hintText: 'Enter your email',
                          controller: form.controllers['email'],
                          validator: form.validators['email'],
                          keyboardType: TextInputType.emailAddress,
                        ),
                      const Spacer(),
                      Column(
                        children: [
                          CustomButton(
                            isLoading: form.isLoading,
                            text: 'Continue',
                            onPressed: form.submit,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
