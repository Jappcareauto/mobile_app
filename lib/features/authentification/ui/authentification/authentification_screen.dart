import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_dimensions.dart';
import '../../../../core/utils/app_images.dart';
import 'controllers/authentification_controller.dart';

class AuthentificationScreen extends GetView<AuthentificationController>
    implements FeatureWidgetInterface {
  const AuthentificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthentificationController(Get.find()));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        const Expanded(
            child: Center(
          child: ImageComponent(
            assetPath: AppImages.auth,
            height: 400,
          ),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                text: 'Login',
                haveBorder: true,
                onPressed: controller.openSignInModal,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Create Account',
                onPressed: controller.openSignUpModal,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ))
      ],
    );
  }

  @override
  Widget buildView([args]) {
    return this;
  }
}
