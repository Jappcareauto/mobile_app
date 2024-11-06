import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/features/profile/ui/settings/widgets/setting_item.dart';
import 'controllers/settings_controller.dart';
import 'package:get/get.dart';

class SettingsScreen extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Settings"),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                const SizedBox(height: 20),
                SettingItem(
                    title: "Edit Profile",
                    icon: FluentIcons.person_24_regular,
                    onTap: controller.goToEditProfile),
                SettingItem(
                    title: "History",
                    icon: FluentIcons.history_24_regular,
                    onTap: controller.goToHistory),
                SettingItem(
                  title: "Payments",
                  icon: FluentIcons.wallet_24_regular,
                  onTap: controller.goToPayments,
                ),
                SettingItem(
                  title: "Notifications",
                  icon: FluentIcons.alert_24_regular,
                  onTap: controller.goToNotifications,
                ),
                SettingItem(
                  title: "Help & Support",
                  icon: FluentIcons.person_support_24_regular,
                  onTap: () {},
                ),
                SettingItem(
                  title: "Privacy Policy",
                  icon: FluentIcons.document_24_regular,
                  onTap: controller.goToPrivacyPolicy,
                ),
                SettingItem(
                  title: "Terms & Conditions",
                  icon: FluentIcons.document_24_regular,
                  onTap: controller.goToTermsAndConditions,
                ),
                SettingItem(
                  title: "Logout",
                  icon: FluentIcons.sign_out_24_regular,
                  onTap: controller.logout,
                ),
                SettingItem(
                  title: "Delete Account",
                  icon: FluentIcons.delete_24_regular,
                  onTap: () {},
                  color: Colors.red,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
