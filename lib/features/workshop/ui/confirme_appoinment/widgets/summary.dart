import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirm_appointment_controller.dart';
import 'package:intl/intl.dart';

class Summary extends GetView<ConfirmAppointmentController> {
  final BookAppointmentController bookController =
      Get.put(BookAppointmentController(Get.find()));
  final images = Get.find<GlobalcontrollerWorkshop>().selectedImages;
  final argument = Get.find<GlobalcontrollerWorkshop>().workshopData;

  Summary({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withValues(alpha: .2)),
          borderRadius: BorderRadius.circular(20),
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
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                Text(argument['serviceCenterName'] ?? "Unknown",
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
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                Text(
                    '${argument['serviceName']?.toString().replaceAll("_", " ").capitalizeFirst} Appointment',
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
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
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
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                Text(argument['serviceId'] ?? "Unknown",
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
                            Obx(
                              () => Text(
                                DateFormat('EEE, MMM dd, yyyy')
                                    .format(argument['selectedDate']),
                                // Format personnalisé
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
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
                            Obx(() => Text(argument['selectedTime'],
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400))),
                          ],
                        )
                      ]),
                ]),
            if (argument['noteController'].isNotEmpty)
              Column(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Note',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal)),
                  Text(argument['noteController'],
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal)),
                ],
              ),
            if (images.isNotEmpty)
              Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Images',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          spacing: 10,
                          children: images.map((imagePath) {
                            return SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  imagePath, // Ajuster la taille de l'image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ));
  }
}
