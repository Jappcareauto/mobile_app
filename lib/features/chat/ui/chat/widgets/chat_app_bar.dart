// import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
// import 'package:jappcare/core/utils/app_dimensions.dart';
// import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
//
//
// import '../controllers/chat_controller.dart';
//
// class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String profileImageUrl;
//   final String username;
//   final String? status;
//
//   const ChatAppBar({
//     Key? key,
//     required this.profileImageUrl,
//     required this.username,
//      this.status,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<ChatController>();
//
//     return AppBar(
//       backgroundColor: Get.theme.scaffoldBackgroundColor,
//       elevation: .0,
//       leadingWidth: 20,
//       centerTitle: false,
//       title: Row(
//         children: [
//           if (Get.isRegistered<FeatureWidgetInterface>(
//               tag: 'AvatarWidget'))
//             Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget')
//                 .buildView({
//               "haveName":true
//             }),
//           SizedBox(width: 10,),
//
//           Text( Get.find<ProfileController>().userInfos?.name?? "Unknow",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
//         ],
//       ),
//
//     );
//   }
//
//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
// }