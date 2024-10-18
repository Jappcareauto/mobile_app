import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_colors.dart';

class DetailItem extends StatelessWidget {
  final String title;
  final String value;
  const DetailItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(
              value,
              style: Get.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
