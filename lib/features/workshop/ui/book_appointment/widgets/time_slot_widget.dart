import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeSlot extends StatelessWidget {
  final String label;
  final String timeRange;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlot({
    super.key,
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
        width: 165,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? Get.theme.primaryColor.withValues(alpha: .2)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Colors.orange
                : const Color(0xF6EFF3FF).withValues(alpha: .95),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.orange : Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              timeRange,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: isSelected ? Colors.orange : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
