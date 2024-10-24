import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;
  final Color? color;
  const SettingItem(
      {super.key,
      required this.title,
      required this.icon,
      this.onTap,
      this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: Get.textTheme.bodyMedium?.copyWith(color: color),
      ),
      onTap: onTap,
    );
  }
}
