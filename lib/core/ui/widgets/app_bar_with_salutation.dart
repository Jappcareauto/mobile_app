import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/home/ui/home/controllers/home_controller.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../interfaces/feature_widget_interface.dart';

class AppBarWithAvatarAndSalutation extends StatelessWidget
    implements PreferredSizeWidget {
  final String greetingMessage;

  const AppBarWithAvatarAndSalutation({
    super.key,
    required this.greetingMessage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      // surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      toolbarHeight: 100,
      leadingWidth: 300,
      leading: Container(
        margin: const EdgeInsets.only(left: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  greetingMessage,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFFADAAAA),
                  ),
                ),
                Obx(() => Get.find<ProfileController>().loading.value
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
                        child: const Text('Name', style: TextStyle(fontSize: 20)),
                      )
                    : Text(
                        Get.find<ProfileController>().userInfos?.name ??
                            'Guest',
                        style: const TextStyle(fontSize: 20),
                      )),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: Get.find<HomeController>().goToNotifications,
            child: const Icon(
              FluentIcons.alert_24_regular,
              size: 30,
              color: Color.fromARGB(255, 167, 171, 184),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
