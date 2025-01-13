import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/ui/widgets/loading_widget.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/ui/interfaces/feature_widget_interface.dart';

class AvatarWidget extends StatelessWidget implements FeatureWidgetInterface {
  final double size;
  final bool canEdit;
  const AvatarWidget({super.key, this.size = 55, this.canEdit = false});

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<ProfileController>(
      autoRemove: false,
      initState: (_) {},
      builder: (_) {
        return _.loading.value
            ? SizedBox(
                height: size,
                width: size,
                child: const LoaderWidget(dense: true))
            : Stack(
                children: [
                  _.updateImageLoading.value
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: ImageComponent(
                            file: _.file,
                            width: size,
                            height: size,
                            borderRadius: 50,
                          ),
                        )
                      : ImageComponent(
                          imageUrl: _.file != null ? null : _.userInfos?.image,
                          file: _.file,
                          onTap: _.goToProfile,
                          width: size,
                          height: size,
                          borderRadius: 50,
                          onErrorWidget:Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Get.theme.primaryColor,
                                width: 2
                              )
                            ),
                              child:  CircleAvatar(
                                backgroundColor: AppColors.black,
                                radius: size,
                                child: Text(
                                  _.userInfos?.name[0].toUpperCase() ?? '',
                                  style: Get.textTheme.headlineLarge?.copyWith(
                                      color: Get.theme.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                           )

                        ),
                  if (canEdit)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 18,
                        child: IconButton(
                            onPressed: _.getAndUpdateProfileImage,
                            icon: const Icon(
                              FluentIcons.edit_24_regular,
                              size: 20,
                            )),
                      ),
                    ),
                ],
              );
      },
    );
  }

  @override
  Widget buildView([args]) {
    return this;
  }
}
