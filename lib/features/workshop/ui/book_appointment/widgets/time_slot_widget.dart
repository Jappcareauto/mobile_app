import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeSlot extends StatelessWidget {
  final String label;
  final String timeRange;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlot({
    required this.label,
    required this.timeRange,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Get.theme.primaryColor.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ?Get.theme.primaryColor.withOpacity(0.2) : Colors.grey,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(timeRange),
          ],
        ),
      ),
    );
  }
}