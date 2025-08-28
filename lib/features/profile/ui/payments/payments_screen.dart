import 'package:flutter/material.dart';
// import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar_with_back_and_avatar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
// import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'controllers/payments_controller.dart';
import 'package:get/get.dart';
import './widgets/credit_card_widget.dart';

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
              child:
                  // Column(children: [
                  Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select a payment method',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.creditCards.length,
                        itemBuilder: (context, index) {
                          return CreditCardWidget(
                              card: controller.creditCards[index]);
                        },
                      ),
                    ),
                    CustomButton(
                        text: "Add payment method",
                        onPressed: controller.selectedMethod.value.isNotEmpty
                            ? () => controller.goToAddPaymentMethods()
                            : null),
                  ],
                ),
              ),

              // const SizedBox(height: 20),
              // SizedBox(
              //   // height: 200,
              //   child: ListView(
              //     scrollDirection: Axis.vertical,
              //     // shrinkWrap: true,
              //     children: [
              //       const SizedBox(width: 20),
              //       ...controller.paymentsMethods.map(
              //         (e) => Obx(
              //           () => Container(
              //             width: 250,
              //             height: 200,
              //             margin: const EdgeInsets.only(right: 20),
              //             decoration: BoxDecoration(
              //               border: Border.all(
              //                 color: controller.selectedMethod.value == e
              //                     ? Colors.orange
              //                     : Colors.transparent,
              //                 width: 2,
              //               ),
              //               borderRadius: BorderRadius.circular(20),
              //             ),
              //             child: ImageComponent(
              //               assetPath: e,
              //               borderRadius: 18,
              //               onTap: () {
              //                 controller.onPaymentMethodsSelected(e);
              //                 print(e);
              //               },
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const Spacer(),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: CustomButton(
              //       text: "Add payment method",
              //       onPressed: controller.selectedMethod.value.isNotEmpty
              //           ? () => controller.goToAddPaymentMethods()
              //           : null),
              // )
              // ]
              // ),
            );
          }),
    );
  }
}
