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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                key: _.formHelper.formKey,
                autovalidateMode: _.formHelper.autovalidateMode.value,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomFormField(
                      label: 'Password',
                      isPassword: true,
                      hintText: 'Enter your password',
                      controller: _.formHelper.controllers['password'],
                      validator: _.formHelper.validators['password'],
                      obscureText: true,
                    ),
                    Spacer(),
                    Column(
                      children: [
                        CustomButton(
                          isLoading: _.formHelper.isLoading,
                          text: 'Login',
                          onPressed: _.formHelper.submit,
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
