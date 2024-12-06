import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'controllers/reset_password_controller.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Reset Password",
      ),
      body: MixinBuilder<ResetPasswordController>(
        builder: (_) {
          final form = _.index.value == 0
              ? _.forgotPasswordFormHelper
              : _.index.value == 1
                  ? _.formHelper
                  : _.resetPasswordFormHelper;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                key: form.formKey,
                autovalidateMode: form.autovalidateMode.value,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    if (_.index.value == 1)
                      CustomFormField(
                        label: 'Code',
                        hintText: 'Enter  receive by email',
                        controller: form.controllers['code'],
                        validator: form.validators['code'],
                        keyboardType: TextInputType.emailAddress,
                      ),
                    if (_.index.value == 2)
                      CustomFormField(
                        label: 'Password',
                        isPassword: true,
                        hintText: 'Enter new password',
                        controller: form.controllers['newPassword'],
                        validator: form.validators['newPassword'],
                        obscureText: true,
                      ),
                    if (_.index.value == 0)
                      CustomFormField(
                        label: 'Email',
                        hintText: 'Enter your email',
                        controller: form.controllers['email'],
                        validator: form.validators['email'],
                        keyboardType: TextInputType.emailAddress,
                      ),
                    Spacer(),
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
    );
  }
}
