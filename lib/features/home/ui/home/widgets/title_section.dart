import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({required this.nameSection, super.key});
  final String nameSection;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            nameSection,
            style: Get.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
