import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/error/ui/commingSoon/controllers/comming_soon_controller.dart';

class CommingSoonScreen extends GetView<CommingSoonController> {
  const CommingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '',
      ),
      body: SafeArea(
        child: Center(
            child: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .15),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: const ImageComponent(
                  height: 200,
                  width: 200,
                  assetPath: AppImages.commingSoon,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Coming Soon',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'This Feature is under development, and will be \n coming soon',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(20),
                child: CustomButton(
                    text: 'Go Home',
                    onPressed: () {
                      Get.back();
                    }),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
