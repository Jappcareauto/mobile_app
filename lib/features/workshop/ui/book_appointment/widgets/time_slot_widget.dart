import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeSlot extends StatelessWidget {
  final String label;
  final String timeRange;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback? onTap;

  const TimeSlot({
    super.key,
    required this.label,
    required this.timeRange,
    required this.isSelected,
    this.isDisabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Opacity(
        opacity: isDisabled ? 0.4 : 1.0,
        child: Container(
          width: 165,
          padding: const EdgeInsets.all(12),
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
                      : const Color(0xF6EFF3FF).withValues(alpha: .95),
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDisabled
                        ? Colors.grey
                        : isSelected
                            ? Colors.orange
                            : Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                timeRange,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: isDisabled
                        ? Colors.grey
                        : isSelected
                            ? Colors.orange
                            : Colors.black),
              ),
              if (isDisabled)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    "Not available",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
