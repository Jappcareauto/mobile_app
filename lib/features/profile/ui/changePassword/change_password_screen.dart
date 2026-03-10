import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/generated/locales.g.dart';
import 'controllers/change_password_controller.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.change_password.tr,
        appBarcolor: Get.theme.scaffoldBackgroundColor,
      ),
      body: GetBuilder<ChangePasswordController>(
        init: ChangePasswordController(Get.find()),
        builder: (controller) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: controller.changePasswordFormHelper.formKey,
                        autovalidateMode: controller
                            .changePasswordFormHelper.autovalidateMode.value,
                        child: Column(
                          spacing: 16,
                          children: [
                            const SizedBox(height: 20),
                            CustomFormField(
                              controller: controller.changePasswordFormHelper
                                  .controllers['oldPassword'],
                              validator: controller.changePasswordFormHelper
                                  .validators['oldPassword'],
                              label: LocaleKeys.old_password.tr,
                              hintText: LocaleKeys.enter_old_password.tr,
                              isPassword: true,
                              obscureText: true,
                            ),
                            CustomFormField(
                              controller: controller.changePasswordFormHelper
                                  .controllers['newPassword'],
                              validator: controller.changePasswordFormHelper
                                  .validators['newPassword'],
                              label: LocaleKeys.new_password.tr,
                              hintText: LocaleKeys.enter_new_password.tr,
                              isPassword: true,
                              obscureText: true,
                            ),
                            CustomFormField(
                              controller: controller.changePasswordFormHelper
                                  .controllers['confirmPassword'],
                              validator: controller.changePasswordFormHelper
                                  .validators['confirmPassword'],
                              label: LocaleKeys.confirm_password.tr,
                              hintText: LocaleKeys.confirm_new_password.tr,
                              isPassword: true,
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(
                    text: LocaleKeys.change_password.tr,
                    onPressed: controller.changePasswordFormHelper.submit,
                    isLoading: controller.changePasswordFormHelper.isLoading,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
