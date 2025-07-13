import 'package:flutter/material.dart';
// import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar_with_back_and_avatar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'controllers/payments_controller.dart';
import 'package:get/get.dart';

class PaymentsScreen extends GetView<PaymentsController> {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(controller.selectedMethod.value);
    return Scaffold(
      appBar: CustomAppBarWithBackAndAvatar(title: "Payment\nMethods"),
      body: GetBuilder<PaymentsController>(
          initState: (_) {},
          builder: (controller) {
            return SafeArea(
              child: Column(children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      const SizedBox(width: 20),
                      ...controller.paymentsMethods.map(
                        (e) => Obx(
                          () => Container(
                            width: 350,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: controller.selectedMethod.value == e
                                    ? Colors.orange
                                    : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ImageComponent(
                              assetPath: e,
                              borderRadius: 18,
                              onTap: () {
                                controller.onPaymentMethodsSelected(e);
                                print(e);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(
                      text: "Add payment method",
                      onPressed: () =>
                          controller.selectedMethod.value.isNotEmpty
                              ? controller.goToAddPaymentMethods()
                              : null),
                )
              ]),
            );
          }),
    );
  }
}
