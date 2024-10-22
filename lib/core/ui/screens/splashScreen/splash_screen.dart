import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import '../../../utils/app_images.dart';
import 'controllers/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController(Get.find()));
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: const Center(
        child: SizedBox(
          width: 250,
          child: ImageComponent(
            assetPath: AppImages.logoWithName,
          ),
        ),
      ),
    );
  }
}
