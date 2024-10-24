import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/app_colors.dart';

class NotificationItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String? date;
  final bool isRead;
  const NotificationItemWidget(
      {super.key,
      required this.title,
      required this.description,
      this.date,
      this.isRead = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightBorder),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                FluentIcons.alert_24_filled,
                color: Get.theme.primaryColor,
              ),
              Expanded(
                child: Text(
                  title,
                  style: Get.textTheme.bodyLarge
                      ?.copyWith(color: Get.theme.primaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(description),
          // const SizedBox(height: 8,),
          // Text(date ?? "", style: const TextStyle(color: Colors.grey),)
        ],
      ),
    );
  }
}
