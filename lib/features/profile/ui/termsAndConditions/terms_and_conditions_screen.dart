import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'controllers/terms_and_conditions_controller.dart';
import 'package:get/get.dart';

class TermsAndConditionsScreen extends GetView<TermsAndConditionsController> {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Terms & Conditions", canBack: true),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(controller.textData),
        ),
      ),
    );
  }
}
