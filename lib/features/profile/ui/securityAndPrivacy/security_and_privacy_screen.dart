import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/features/profile/ui/settings/widgets/setting_item.dart';
import 'package:jappcare/generated/locales.g.dart';
import 'controllers/security_and_privacy_controller.dart';

class SecurityAndPrivacyScreen extends GetView<SecurityAndPrivacyController> {
  const SecurityAndPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.security_and_privacy.tr,
        appBarcolor: Get.theme.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SettingItem(
                title: LocaleKeys.change_password.tr,
                icon: FluentIcons.lock_closed_24_regular,
                onTap: controller.goToChangePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
