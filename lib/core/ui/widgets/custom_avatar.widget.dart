import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';

class CustomAvatarWidget extends StatelessWidget {
  final double size;
  final bool canEdit;
  final String name;
  final bool? haveName;
  const CustomAvatarWidget(
      {super.key,
      this.size = 55,
      required this.name,
      this.canEdit = false,
      this.haveName = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageComponent(
            // imageUrl: controller.file != null
            //     ? null
            //     : controller.userInfos?.image,
            imageUrl: null,
            // file: controller.file,
            onTap: () {},
            width: size,
            height: size,
            borderRadius: 50,
            onErrorWidget: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Get.theme.primaryColor, width: 2)),
              child: haveName == true
                  ? Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.black,
                          radius: size,
                          child: Text(
                            name[0].toUpperCase(),
                            style: Get.textTheme.headlineLarge?.copyWith(
                                color: Get.theme.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        )
                      ],
                    )
                  : CircleAvatar(
                      backgroundColor: AppColors.black,
                      radius: size,
                      child: Text(
                        name[0].toUpperCase(),
                        style: Get.textTheme.headlineLarge?.copyWith(
                            color: Get.theme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            )),
      ],
    );
  }
}
