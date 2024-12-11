import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_dimensions.dart';


import '../controllers/chat_controller.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String profileImageUrl;
  final String username;
  final String? status;

  const ChatAppBar({
    Key? key,
    required this.profileImageUrl,
    required this.username,
     this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();

    return AppBar(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      elevation: .0,
      leadingWidth: 20,
      centerTitle: false,
      title: Row(
        children: [

          CircleAvatar(
            backgroundImage: AssetImage(profileImageUrl),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username,
                  style: Get.textTheme.bodyMedium?.copyWith(
                      color: Colors.black, fontWeight: FontWeight.normal , fontSize: 25)),
              Row(
                children: [
                  const CircleAvatar(
                      backgroundColor: Colors.white, radius: 4),
                  const SizedBox(width:4),

                ],
              ),
            ],
          ),
        ],
      ),
      actions: [

        SizedBox(width: 8),
      CircleAvatar(

        backgroundColor: Colors.white,
        child:
      InkWell(
                onTap: controller.openMore,
                child: Icon(FluentIcons.more_circle_32_filled, color: Colors.black)),
      ),

        SizedBox(width: 8),

      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}