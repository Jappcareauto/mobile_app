import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/location_option_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/time_slot_widget.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Expanded(
                    child: TimeSlot(
                      label: "Morning",
                      timeRange: "8:00 AM - 12:00 AM",
                      isSelected: controller.selectedTime.value == "MORNING",
                      onTap: () => controller.selectTime("MORNING"),
                    ),
                  )),
              const SizedBox(width: 10),
              Obx(() => Expanded(
                    child: TimeSlot(
                      label: "Afternoon",
                      timeRange: "12:00 PM - 5:00 PM",
                      isSelected: controller.selectedTime.value == "AFTERNOON",
                      onTap: () => controller.selectTime("AFTERNOON"),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              "Where do you want the service",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Expanded(
                    child: LocationOption(
                      label: "Home",
                      icon: FluentIcons.home_12_regular,
                      isSelected: controller.selectedLocation.value == "HOME",
                      onTap: () => controller.selectLocation("HOME"),
                    ),
                  )),
              const SizedBox(width: 10),
              Obx(() => Expanded(
                    child: LocationOption(
                      label: "Garage",
                      icon: FluentIcons.home_12_regular,
                      isSelected: controller.selectedLocation.value == "GARAGE",
                      onTap: () => controller.selectLocation("GARAGE"),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Expanded(
                    child: LocationOption(
                      label: "Service center",
                      icon: FluentIcons.home_12_regular,
                      isSelected:
                          controller.selectedLocation.value == "SERVICE_CENTER",
                      onTap: () => controller.selectLocation("SERVICE_CENTER"),
                    ),
                  )),
              const SizedBox(width: 10),
              Obx(() => Expanded(
                    child: LocationOption(
                      label: "Custom",
                      icon: FluentIcons.home_12_regular,
                      isSelected: controller.selectedLocation.value == "CUSTOM",
                      onTap: () => controller.selectLocation("CUSTOM"),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
