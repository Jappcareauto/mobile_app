import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:get/get.dart';

class CustomAppBarWithBackAndAvatar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool canBack;
  const CustomAppBarWithBackAndAvatar({
    super.key,
    this.canBack = true,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: title,
      canBack: canBack,
      appBarcolor: Get.theme.scaffoldBackgroundColor,
      actions: [
        if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
          Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
      ],
    );
  }

  @override
  Size get preferredSize => Size(Get.width, 115);
}
