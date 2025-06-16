import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/features/chat/ui/chat/controllers/chat_details_controller.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';

class ChatAppointmentSummary extends GetView<ChatDetailsController> {
  const ChatAppointmentSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatDetailsController>(
        // initState: (_) {},
        builder: (controller) {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withValues(alpha: .2)),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Service Offered by',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal)),
                  Text(controller.appointment.serviceCenter?.name ?? "Unknown",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Item',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal)),
                  Text(
                      '${controller.appointment.service?.title.toString().replaceAll("_", " ").capitalizeFirst} Appointment',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('From',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal)),
                  Row(
                    children: [
                      if (Get.isRegistered<FeatureWidgetInterface>(
                          tag: 'AvatarWidget'))
                        Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget')
                            .buildView({"haveName": true}),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                          Get.find<ProfileController>().userInfos?.name ??
                              "Unknown",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
              // Column(
              //   spacing: 5,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     const Text('Estimated inspection fee',
              //         style:
              //             TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
              //     Text('${argument['servicePrice']} Frs',
              //         style:
              //             TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              //   ],
              // ),
              Column(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Service ID',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal)),
                  Text(
                      controller.appointment.service?.id.toString() ??
                          "Unknown",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 10,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                FluentIcons.calendar_12_regular,
                                size: 24,
                              ),
                              Text(
                                DateFormat('EEE, MMM dd, yyyy').format(
                                    DateTime.parse(
                                        controller.appointment.createdAt)),
                                // Format personnalisé
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                FluentIcons.clock_12_regular,
                                size: 24,
                              ),
                              Text(controller.appointment.timeOfDay,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            ],
                          )
                        ]),
                  ]),
              if (controller.appointment.note != null &&
                  controller.appointment.note!.isNotEmpty)
                Column(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Note',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal)),
                    Text(controller.appointment.note!,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal)),
                  ],
                ),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomButton(
                  strech: false,
                  haveBorder: true,
                  borderRadius: BorderRadius.circular(30),
                  width: 140,
                  height: 40,
                  text: 'See Details',
                  onPressed: controller.goToAppointmentDetail,
                ),
              ),
              // if (images.isNotEmpty)
              //   Column(
              //     spacing: 10,
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Text('Images',
              //           style: TextStyle(
              //               fontSize: 14, fontWeight: FontWeight.normal)),
              //       SingleChildScrollView(
              //         scrollDirection: Axis.horizontal,
              //         child: Obx(
              //           () => Padding(
              //             padding: const EdgeInsets.only(right: 20.0),
              //             child: Row(
              //               spacing: 10,
              //               children: images.map((imagePath) {
              //                 return SizedBox(
              //                   height: 100,
              //                   width: MediaQuery.of(context).size.width * 0.25,
              //                   child: ClipRRect(
              //                     borderRadius: BorderRadius.circular(12),
              //                     child: Image.file(
              //                       imagePath, // Ajuster la taille de l'image
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                 );
              //               }).toList(),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
            ],
          ));
    });
  }
}
