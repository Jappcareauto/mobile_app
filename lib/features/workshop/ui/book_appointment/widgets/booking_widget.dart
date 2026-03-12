import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/location_option_widget.dart';

class BookingWidget extends GetView<BookAppointmentController> {
  const BookingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "When",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Select Day",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // const SizedBox(height: 16),
          Obx(() => CalendarDatePicker(
                initialDate: controller.selectedDate.value,
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1),
                onDateChanged: (date) => controller.selectDate(date),
              )),
          // const SizedBox(height: 16),
          Obx(() => Text(
                DateFormat("EEE, MMM dd, yyyy")
                    .format(controller.selectedDate.value),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.primaryColor,
                ),
              )),
          const SizedBox(height: 16),
          const Text(
            "Time",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Morning",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Obx(() {
            // Morning hours: 8am - 11am
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(4, (index) {
                final hour = 8 + index;
                final isDisabled = controller.isHourDisabled(hour);
                final isSelected = controller.selectedHour.value == hour;
                final label = hour > 12
                    ? '${hour - 12}:00 PM'
                    : hour == 12
                        ? '12:00 PM'
                        : '$hour:00 AM';

                return GestureDetector(
                  onTap: isDisabled ? null : () => controller.selectHour(hour),
                  child: Opacity(
                    opacity: isDisabled ? 0.4 : 1.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isDisabled
                            ? Colors.grey.withValues(alpha: 0.1)
                            : isSelected
                                ? Get.theme.primaryColor.withValues(alpha: .2)
                                : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDisabled
                              ? Colors.grey.withValues(alpha: 0.3)
                              : isSelected
                                  ? Colors.orange
                                  : const Color(0xF6EFF3FF)
                                      .withValues(alpha: .95),
                        ),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: isDisabled
                              ? Colors.grey
                              : isSelected
                                  ? Colors.orange
                                  : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
          const SizedBox(height: 12),
          const Text(
            "Afternoon",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Obx(() {
            // Afternoon hours: 12pm - 4pm
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(5, (index) {
                final hour = 12 + index;
                final isDisabled = controller.isHourDisabled(hour);
                final isSelected = controller.selectedHour.value == hour;
                final label = hour > 12 ? '${hour - 12}:00 PM' : '12:00 PM';

                return GestureDetector(
                  onTap: isDisabled ? null : () => controller.selectHour(hour),
                  child: Opacity(
                    opacity: isDisabled ? 0.4 : 1.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isDisabled
                            ? Colors.grey.withValues(alpha: 0.1)
                            : isSelected
                                ? Get.theme.primaryColor.withValues(alpha: .2)
                                : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDisabled
                              ? Colors.grey.withValues(alpha: 0.3)
                              : isSelected
                                  ? Colors.orange
                                  : const Color(0xF6EFF3FF)
                                      .withValues(alpha: .95),
                        ),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: isDisabled
                              ? Colors.grey
                              : isSelected
                                  ? Colors.orange
                                  : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              "Where do you want the service",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 12,
            children: [
              Obx(() => Expanded(
                    child: LocationOption(
                        label: "Home",
                        icon: FluentIcons.home_12_regular,
                        isSelected: controller.selectedLocation.value == "HOME",
                        onTap: () {
                          controller.selectLocation("HOME");
                          controller.getUserLocationAndAnimateCamera();
                        }),
                  )),
              Obx(() => Expanded(
                    child: LocationOption(
                      label: "Service center",
                      icon: FluentIcons.home_12_regular,
                      isSelected:
                          controller.selectedLocation.value == "SERVICE_CENTER",
                      onTap: () => controller.selectLocation("SERVICE_CENTER"),
                    ),
                  )),
              // Obx(() => Expanded(
              //       child: LocationOption(
              //         label: "Garage",
              //         icon: FluentIcons.home_12_regular,
              //         isSelected: controller.selectedLocation.value == "GARAGE",
              //         onTap: () => controller.selectLocation("GARAGE"),
              //       ),
              //     )),
            ],
          ),
          // const SizedBox(height: 12),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   spacing: 12,
          //   children: [
          //     Obx(() => Expanded(
          //           child: LocationOption(
          //             label: "Service center",
          //             icon: FluentIcons.home_12_regular,
          //             isSelected:
          //                 controller.selectedLocation.value == "SERVICE_CENTER",
          //             onTap: () => controller.selectLocation("SERVICE_CENTER"),
          //           ),
          //         )),
          //     Obx(() => Expanded(
          //           child: LocationOption(
          //             label: "Custom",
          //             icon: FluentIcons.home_12_regular,
          //             isSelected: controller.selectedLocation.value == "CUSTOM",
          //             onTap: () => controller.selectLocation("CUSTOM"),
          //           ),
          //         )),
          //   ],
          // ),
        ],
      ),
    );
  }
}
