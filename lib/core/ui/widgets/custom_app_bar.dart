import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? titleSize;
  final Color? appBarcolor;
  final bool canBack;
  final List<Widget>? actions;
  const CustomAppBar(
      {super.key,
      required this.title,
      this.canBack = true,
      this.titleSize,
      this.actions,
      this.appBarcolor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: appBarcolor,
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
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    color: Colors.black,
                    icon: const Icon(
                      FluentIcons.arrow_left_24_regular, // Fluent UI icon
                      color: Colors.black, // Icon color
                    ),
                  ),
                Text(title,
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold)),
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
