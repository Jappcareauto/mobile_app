import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/generated/locales.g.dart';
import 'controllers/manage_account_controller.dart';

class ManageAccountScreen extends GetView<ManageAccountController> {
  const ManageAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.manage_account.tr,
        appBarcolor: Get.theme.scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              LocaleKeys.account_data_info.tr,
              style: Get.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: LocaleKeys.request_account_data.tr,
              onPressed: controller.requestAccountData,
              haveBorder: true,
              borderColor: Get.theme.primaryColor,
              textColor: Get.theme.primaryColor,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: LocaleKeys.delete_account.tr,
              onPressed: controller.deleteAccount,
              color: Colors.red,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
