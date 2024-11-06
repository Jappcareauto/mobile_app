import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'controllers/payments_controller.dart';
import 'package:get/get.dart';

class PaymentsScreen extends GetView<PaymentsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Payment\nMethods", canBack: true),
      body: Column(children: [
        const SizedBox(height: 20),
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              const SizedBox(width: 20),
              ...controller.payments
                  .map((e) => Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: ImageComponent(
                          assetPath: e,
                          onTap: () => controller.onPaymentMethodsSelected(e),
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomButton(text: "Add payment method", onPressed: () {}),
        ),
      ]),
    );
  }
}
