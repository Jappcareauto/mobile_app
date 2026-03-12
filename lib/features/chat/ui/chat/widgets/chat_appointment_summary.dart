import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/chat/ui/chat/controllers/chat_details_controller.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/features/profile/ui/profile/widgets/avatar_widget.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';

class ChatAppointmentSummary extends GetView<ChatDetailsController> {
  final AppointmentEntity? appointmentData;

  const ChatAppointmentSummary({super.key, this.appointmentData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatDetailsController>(builder: (controller) {
      final appt = appointmentData ?? controller.appointment;
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
            spacing: 16,
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
                  Text(appt.serviceCenter?.name ?? "Unknown",
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
                      '${appt.service?.title.toString().replaceAll("_", " ").capitalizeFirst} Appointment',
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
                      AvatarWidget(size: 40, canEdit: false),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(controller.currentUser?.name ?? "Unknown",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
              Column(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Service ID',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal)),
                  Text(appt.service?.id.toString() ?? "Unknown",
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
                                appt.createdAt != null
                                    ? DateFormat('EEE, MMM dd, yyyy')
                                        .format(DateTime.parse(appt.createdAt!))
                                    : '',
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
                              Text(appt.timeOfDay ?? '',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            ],
                          )
                        ]),
                  ]),
              if (appt.note != null && appt.note!.isNotEmpty)
                Column(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Note',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal)),
                    Text(appt.note!,
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
            ],
          ));
    });
  }
}
