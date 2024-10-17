import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> labels;
  final Color? selectedColor;
  final Color? unselectedColor;
  final ValueChanged<int> onTabSelected;

  CustomTabBar({
    required this.labels,
    this.selectedColor,
    this.unselectedColor,
    required this.onTabSelected,
  });

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: widget.labels.asMap().entries.map((entry) {
        int index = entry.key;
        String label = entry.value;
        bool isSelected = selectedIndex == index;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? (widget.selectedColor ?? Get.theme.primaryColor)
                : (widget.unselectedColor ??
                    Get.theme.primaryColor.withOpacity(.1)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTabSelected(index);
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
    );
  }
}
