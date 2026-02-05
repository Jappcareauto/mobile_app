import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> labels;
  final Color? selectedColor;
  final Color? unselectedColor;
  final ValueChanged<int> onTabSelected;
  final int selectedIndex;

  const CustomTabBar({
    super.key,
    required this.labels,
    this.selectedColor,
    this.unselectedColor,
    required this.onTabSelected,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: labels.asMap().entries.map((entry) {
          int index = entry.key;
          String label = entry.value;
          bool isSelected = selectedIndex == index;

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? (selectedColor ?? Get.theme.primaryColor)
                  : (unselectedColor ??
                      Get.theme.primaryColor.withValues(alpha: .1)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: GestureDetector(
              onTap: () {
                onTabSelected(index);
              },
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : null,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
