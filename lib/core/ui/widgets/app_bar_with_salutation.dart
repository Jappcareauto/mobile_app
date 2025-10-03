// import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/home/ui/home/controllers/home_controller.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../interfaces/feature_widget_interface.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWithAvatarAndSalutation extends StatelessWidget {
  const AppBarWithAvatarAndSalutation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController(Get.find()), permanent: true);
    var profileController = Get.find<ProfileController>();
    return SliverAppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      toolbarHeight: 100,
      leadingWidth: 300,
      leading: Container(
        margin: const EdgeInsets.only(left: 20),
        child: Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
            // const SizedBox(width: 5),
            Obx(
              () => profileController.loading.value
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: const Text('Loading...',
                          style: TextStyle(fontSize: 20)),
                    )
                  : Text(
                      "Hi, ${profileController.userInfos?.name ?? ''}",
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
          padding: const EdgeInsets.all(20),
          child: InkWell(
              splashColor: Colors.transparent,
              onTap: Get.find<HomeController>().goToNotifications,
              child: SvgPicture.asset(
                AppImages.notification,
                width: 22.5, // optional
                height: 25, // optional
              )

              // const Icon(FluentIcons.alert_24_regular,
              //     size: 30, color: Color.fromRGBO(20, 27, 52, 1.0)),
              ),
        ),
      ],
    );
  }
}
