import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/utils/app_dimensions.dart';
import 'package:jappcare/features/home/ui/selectLanguage/widgets/custom_radio_button.dart';
import 'controllers/select_language_controller.dart';
import 'package:get/get.dart';

class SelectLanguageScreen extends GetView<SelectLanguageController> {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Preferred\nLanguage', canBack: false),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium),
        child: GetBuilder<SelectLanguageController>(
          initState: (_) {},
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                CustomRadioButtonWidget(
                    language: 'English',
                    groupValue: controller.groupValue,
                    isSelected: controller.selectedLanguage == 'English',
                    onChanged: controller.changeLanguage),
                const SizedBox(height: 8),
                CustomRadioButtonWidget(
                    language: 'Français',
                    groupValue: controller.groupValue,
                    isSelected: controller.selectedLanguage == 'Français',
                    onChanged: controller.changeLanguage),
              ],
            );
          },
        ),
      ),
    );
  }
}
