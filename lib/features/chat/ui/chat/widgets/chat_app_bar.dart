import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_avatar.widget.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String profileImageUrl;
  final String username;
  final String? status;

  const ChatAppBar({
    super.key,
    required this.profileImageUrl,
    required this.username,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<ChatController>();

    return AppBar(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      elevation: .0,
      leadingWidth: 40,
      leading: Padding(
        padding: EdgeInsets.only(left: 10),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: Get.back,
        ),
      ),
      centerTitle: false,
      toolbarHeight: 80,
      title: Row(
        spacing: 10,
        children: [
          CustomAvatarWidget(
            name: username,
            haveName: false,
            // size: 50,
          ),
          // if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
          //   Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget')
          //       .buildView({"haveName": true}),
          Text(username,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
        ],
      ),
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.more_vert),
      //     onPressed: () {},
      //   ),
      // ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(Get.width, 80);
}
