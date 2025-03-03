import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/ui/sucess_payment/controller/success_payment_controller.dart';

class SucessPaymentScreen extends GetView<SuccessPaymentController> {
  const SucessPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        actions: [
          if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
            Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
        ],
      ),
      body: SafeArea(
        child: Center(
            child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: const ImageComponent(
                  height: 100,
                  width: 100,
                  assetPath: AppImages.recepit,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Your Payment of'),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '5,000Frs',
                    style: Get.textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text('for')
                ],
              ),
              const Text('booking fee is successful'),
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(20),
                child: CustomButton(
                    text: 'Done',
                    onPressed: () {
                      controller.goToAppointmentDetails();
                    }),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
