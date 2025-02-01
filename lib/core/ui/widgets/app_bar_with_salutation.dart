import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/home/ui/home/controllers/home_controller.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../interfaces/feature_widget_interface.dart';

class AppBarWithAvatarAndSalutation extends StatelessWidget {
  const AppBarWithAvatarAndSalutation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController(Get.find()), permanent: true);
    return SliverAppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
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
            Obx(
                  () => Get.find<ProfileController>().loading.value
                  ? Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: const Text('Loading...',
                    style: TextStyle(fontSize: 20)),
              )
                  : Text(
                "Hi, ${Get.find<ProfileController>().userInfos?.name ?? ''}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
}
