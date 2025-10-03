import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final Function()? onTap;
  final Color? color;
  const SettingItem(
      {super.key,
      required this.title,
      required this.icon,
      this.onTap,
      this.trailing,
      this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color,),
      title: Text(
        title,
        style: Get.textTheme.bodyMedium?.copyWith(color: color),
      ),
      onTap: onTap,
      trailing: trailing ?? Icon(FluentIcons.ios_arrow_rtl_24_filled, color: color, size: 16,),
    );
  }
}
