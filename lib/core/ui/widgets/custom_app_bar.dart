import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? titleSize;
  final bool canBack;
  final List<Widget>? actions;
  const CustomAppBar(
      {super.key,
      required this.title,
      this.canBack = true,
      this.titleSize,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: canBack ? Get.back : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (canBack)
                  const Icon(
                    FluentIcons.arrow_left_24_regular,
                    color: Colors.black,
                  ),
                Text(title,
                    style: const TextStyle(
                      fontSize: 28,
                    )),
              ],
            ),
          ),
          if (actions != null)
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: actions!),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(Get.width, 100);
}
