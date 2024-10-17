import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRadioButtonWidget extends StatelessWidget {
  final bool isSelected;
  final String language;
  final String groupValue;
  final Function(String?)? onChanged;
  const CustomRadioButtonWidget(
      {super.key,
      required this.isSelected,
      required this.language,
      this.onChanged,
      required this.groupValue});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: () => onChanged?.call(language),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Get.theme.primaryColor.withOpacity(.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Get.theme.primaryColor : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Radio<String>(
              value: language,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: Get.theme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
