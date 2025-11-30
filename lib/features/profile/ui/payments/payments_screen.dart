import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
// import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar_with_back_and_avatar.dart';
// import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
// import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'controllers/payments_controller.dart';
import 'package:get/get.dart';
// import './widgets/credit_card_widget.dart';

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
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.lightBorder,
                          width: 1,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: controller.goToAddMtnMoneyPaymentMethod,
                          splashColor:
                              Get.theme.primaryColor.withValues(alpha: 0.2),
                          highlightColor:
                              Get.theme.primaryColor.withValues(alpha: 0.1),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 12,
                                  children: [
                                    ImageComponent(
                                      assetPath: AppImages.mtnLogo,
                                    ),
                                    Text(
                                      "MTN Momo",
                                      style: Get.textTheme.bodyMedium,
                                    )
                                  ],
                                ),
                                Row(
                                  spacing: 6,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FluentIcons.add_16_regular,
                                      color: AppColors.greyText,
                                      size: 18,
                                    ),
                                    Text(
                                      "Add Number",
                                      style: Get.textTheme.bodyMedium
                                          ?.copyWith(color: AppColors.greyText),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.lightBorder,
                          width: 1,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: controller.goToAddOrangeMoneyPaymentMethod,
                          splashColor:
                              Get.theme.primaryColor.withValues(alpha: 0.2),
                          highlightColor:
                              Get.theme.primaryColor.withValues(alpha: 0.1),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 12,
                                  children: [
                                    ImageComponent(
                                      assetPath: AppImages.orangeLogo,
                                    ),
                                    Text(
                                      "Orange Money",
                                      style: Get.textTheme.bodyMedium,
                                    )
                                  ],
                                ),
                                Row(
                                  spacing: 6,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FluentIcons.add_16_regular,
                                      color: AppColors.greyText,
                                      size: 18,
                                    ),
                                    Text(
                                      "Add Number",
                                      style: Get.textTheme.bodyMedium
                                          ?.copyWith(color: AppColors.greyText),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.lightBorder,
                          width: 1,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: controller.goToAddCardPaymentMethod,
                          splashColor:
                              Get.theme.primaryColor.withValues(alpha: 0.2),
                          highlightColor:
                              Get.theme.primaryColor.withValues(alpha: 0.1),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 12,
                                  children: [
                                    ImageComponent(
                                      assetPath: AppImages.cardLogo,
                                      color: Colors.white,
                                      height: 34,
                                      width: 34,
                                    ),
                                    Text(
                                      "Card",
                                      style: Get.textTheme.bodyMedium,
                                    )
                                  ],
                                ),
                                Row(
                                  spacing: 6,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FluentIcons.add_16_regular,
                                      color: AppColors.greyText,
                                      size: 18,
                                    ),
                                    Text(
                                      "Add Number",
                                      style: Get.textTheme.bodyMedium
                                          ?.copyWith(color: AppColors.greyText),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Expanded(
                    //   child: ListView.builder(
                    //     itemCount: controller.creditCards.length,
                    //     itemBuilder: (context, index) {
                    //       return CreditCardWidget(
                    //           card: controller.creditCards[index]);
                    //     },
                    //   ),
                    // ),
                    // CustomButton(
                    //     text: "Add payment method",
                    //     onPressed: controller.selectedMethod.value.isNotEmpty
                    //         ? () => controller.goToAddPaymentMethods()
                    //         : null),
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
