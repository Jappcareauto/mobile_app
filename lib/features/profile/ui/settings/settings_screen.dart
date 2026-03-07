import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/features/profile/ui/settings/widgets/setting_item.dart';
import 'package:jappcare/generated/locales.g.dart';
import 'controllers/settings_controller.dart';
import 'package:get/get.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.settings.tr,
          appBarcolor: Get.theme.scaffoldBackgroundColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                const SizedBox(height: 20),
                SettingItem(
                    title: LocaleKeys.edit_profile.tr,
                    icon: FluentIcons.person_24_regular,
                    onTap: controller.goToEditProfile),
                SettingItem(
                    title: LocaleKeys.manage_account.tr,
                    icon: FluentIcons.person_accounts_24_regular,
                    onTap: controller.goToManageAccount),
                SettingItem(
                    title: LocaleKeys.history.tr,
                    icon: FluentIcons.history_24_regular,
                    onTap: controller.goToHistory),
                SettingItem(
                  title: LocaleKeys.payments.tr,
                  icon: FluentIcons.wallet_24_regular,
                  onTap: controller.goToPayments,
                ),
                SettingItem(
                  title: LocaleKeys.notifications.tr,
                  icon: FluentIcons.alert_24_regular,
                  onTap: controller.goToNotifications,
                ),
                SettingItem(
                  title: LocaleKeys.language.tr,
                  icon: FluentIcons.local_language_24_regular,
                  onTap: controller.goToLanguage,
                ),
                SettingItem(
                  title: LocaleKeys.privacy_policy.tr,
                  icon: FluentIcons.document_24_regular,
                  onTap: controller.goToPrivacyPolicy,
                ),
                SettingItem(
                  title: LocaleKeys.terms_and_conditions.tr,
                  icon: FluentIcons.document_24_regular,
                  onTap: controller.goToTermsAndConditions,
                ),
                const SizedBox(height: 40),
                SettingItem(
                  title: LocaleKeys.logout.tr,
                  icon: FluentIcons.sign_out_24_regular,
                  onTap: controller.logout,
                  color: Colors.red,
                  trailing: SizedBox(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
