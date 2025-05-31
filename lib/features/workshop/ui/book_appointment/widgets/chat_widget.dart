import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatWidget extends StatelessWidget {
  final Function? onTap;
  const ChatWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.circular(15)),
        child: Icon(
          FluentIcons.chat_16_filled,
          color: Get.theme.scaffoldBackgroundColor,
          size: 30,
        ),
      ),
    );
  }
}
