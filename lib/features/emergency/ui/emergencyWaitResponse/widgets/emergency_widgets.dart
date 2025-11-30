import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/emergency/ui/emergency/controllers/emergency_controller.dart';
import 'package:jappcare/features/emergency/ui/emergencyDetail/controllers/emergency_detail_controller.dart';
import 'package:jappcare/features/emergency/ui/emergencyWaitResponse/controllers/emergency_wait_response_controller.dart';
import 'package:jappcare/features/emergency/ui/emergencyWaitResponse/widgets/detail_response_widgets.dart';
import 'package:jappcare/features/home/ui/home/widgets/notification_widget.dart';

class EmergencyWidgets extends GetView<EmergencyWaitResponseController> {
  final bool _isExpanded = true; // Contrôle l'affichage du Row
  final argument = Get.arguments;
  final EmergencyDetailController emergencyDetailController =
      EmergencyDetailController(Get.find());
  final EmergencyController emergencyController =
      EmergencyController(Get.find());

  EmergencyWidgets({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(32)),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        FluentIcons.arrow_left_12_regular,
                        size: 24,
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      controller.isExpanded.value =
                          !controller.isExpanded.value;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(32)),
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        controller.isExpanded.value == true
                            ? FluentIcons.arrow_minimize_16_filled
                            : FluentIcons.arrow_maximize_16_filled,
                        size: 24,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              height: controller.isExpanded.value
                  ? MediaQuery.of(context).size.height * .7
                  : MediaQuery.of(context).size.height * .4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Waiting for response...',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const NotificationWidget(
                      haveTitle: false,
                      textSize: 14,
                      bodyText:
                          'Your request has been sent, waiting for a response from a service provider',
                      coloriage: AppColors.primary,
                      icon: FluentIcons.alert_16_regular,
                      backgroundColor: AppColors.secondary,
                      title: ''),
                  const SizedBox(height: 8),
                  Text(
                    "Added Note",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    argument['note'].toString(),
                  ),
                  const SizedBox(height: 16),
                  if (controller.isExpanded.value) ...[
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Stated Issue",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                argument['issue'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Column(
                          children: [
                            Text(
                              "Estimated Price",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "7000 Frs",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Vehicle",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              Text(argument['name']),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const ImageComponent(
                            width: 200,
                            assetPath: AppImages.carWhite,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const DetailResponseWidgets()
                  ],
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CustomButton(
                          text: 'Cancel Request',
                          strech: false,
                          haveBorder: true,
                          width: 270,
                          isLoading: controller.loading,
                          height: 52,
                          onPressed: () {
                            controller.declinedEmergency(
                                argument['emergencyId'], "DECLINED");
                          }),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.processChat();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(width: 1)),
                          child: const Icon(
                            FluentIcons.chat_16_filled,
                            size: 24,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
