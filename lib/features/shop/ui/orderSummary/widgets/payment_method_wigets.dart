import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/core/utils/enums.dart';
import 'package:jappcare/features/shop/ui/orderSummary/controllers/order_summary_controller.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback ontap;
  PaymentMethodWidget(
      {super.key, required this.ontap, required this.buttonText});
  final OrderSummaryController orderSummary =
      Get.put(OrderSummaryController(Get.find()));
  @override
  Widget build(BuildContext context) {
    return Obx(() => Center(
          child: SizedBox(
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Text(
                      'How would you like to pay ?',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    orderSummary.selectPaymentMethod(PaymentMethod.mtn.value);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: orderSummary.selectedMethod.value ==
                                PaymentMethod.mtn.value
                            ? Get.theme.primaryColor.withValues(alpha: 0.2)
                            : null,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: orderSummary.selectedMethod.value ==
                                    PaymentMethod.mtn.value
                                ? Get.theme.primaryColor
                                : Get.theme.scaffoldBackgroundColor,
                            width: 2)),
                    child: Row(
                      children: [
                        const ImageComponent(
                          height: 32,
                          width: 32,
                          assetPath: AppImages.mtnLogo,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'MTN MoMo',
                          style: TextStyle(
                              color: orderSummary.selectedMethod.value ==
                                      PaymentMethod.mtn.value
                                  ? Get.theme.primaryColor
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .35,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('add Number');
                          },
                          child: Text(
                            '+ Add Number',
                            style: TextStyle(
                              color: orderSummary.selectedMethod.value ==
                                      PaymentMethod.mtn.value
                                  ? Get.theme.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    orderSummary
                        .selectPaymentMethod(PaymentMethod.orange.value);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: orderSummary.selectedMethod.value ==
                                PaymentMethod.orange.value
                            ? Get.theme.primaryColor.withValues(alpha: 0.2)
                            : null,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: orderSummary.selectedMethod.value ==
                                    PaymentMethod.orange.value
                                ? Get.theme.primaryColor
                                : Get.theme.scaffoldBackgroundColor,
                            width: 2)),
                    child: Row(
                      children: [
                        const ImageComponent(
                          height: 32,
                          width: 32,
                          assetPath: AppImages.orangeLogo,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Orange Money',
                          style: TextStyle(
                              color: orderSummary.selectedMethod.value ==
                                      PaymentMethod.orange.value
                                  ? Get.theme.primaryColor
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .22,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('add Number');
                          },
                          child: Text(
                            '+237 00000000',
                            style: TextStyle(
                              color: orderSummary.selectedMethod.value ==
                                      PaymentMethod.orange.value
                                  ? Get.theme.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    orderSummary.selectPaymentMethod(PaymentMethod.card.value);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: orderSummary.selectedMethod.value ==
                                PaymentMethod.card.value
                            ? Get.theme.primaryColor.withValues(alpha: 0.2)
                            : null,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: orderSummary.selectedMethod.value ==
                                    PaymentMethod.card.value
                                ? Get.theme.primaryColor
                                : Get.theme.scaffoldBackgroundColor,
                            width: 2)),
                    child: Row(
                      children: [
                        const ImageComponent(
                          height: 32,
                          width: 32,
                          assetPath: AppImages.cardLogo,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Card',
                          style: TextStyle(
                              color: orderSummary.selectedMethod.value ==
                                      PaymentMethod.card.value
                                  ? Get.theme.primaryColor
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .38,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('add Number');
                          },
                          child: Text(
                            '**** **** **** 1234',
                            style: TextStyle(
                              color: orderSummary.selectedMethod.value ==
                                      PaymentMethod.card.value
                                  ? Get.theme.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: buttonText,
                  onPressed: ontap,
                ),
              ],
            ),
          ),
        ));
  }
}
