import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'controllers/network_error_controller.dart';
import 'package:get/get.dart';

class NetworkErrorScreen extends GetView<NetworkErrorController> {
  const NetworkErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: '',
          appBarcolor: Get.theme.scaffoldBackgroundColor,
        ),
        body: SafeArea(
          child: Center(
              child: Container(
            margin: EdgeInsets.only(top: Get.size.height * .10),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const ImageComponent(
                    height: 200,
                    width: 200,
                    assetPath: AppImages.noInternet,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 24,
                  children: [
                    Text(
                      'No Internet',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'It seems you are not connected to the internet, please connect to the internet and try again.',
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
                  child: CustomButton(text: 'Try Again', onPressed: null),
                ),
              ],
            ),
          )),
        ));
  }
}
