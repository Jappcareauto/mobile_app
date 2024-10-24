import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/ui/widgets/loading_widget.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';

import '../../../../../core/ui/interfaces/feature_widget_interface.dart';

class AvatarWidget extends StatelessWidget implements FeatureWidgetInterface {
  final double size;
  const AvatarWidget({super.key, this.size = 55});

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<ProfileController>(
      init: ProfileController(Get.find()),
      initState: (_) {},
      builder: (_) {
        return _.loading.value
            ? SizedBox(
                height: size, width: size, child: LoaderWidget(dense: true))
            : ImageComponent(
                imageUrl: _.userInfos?.image,
                onTap: _.goToProfile,
                width: size,
                height: size,
                borderRadius: 50,
              );
      },
    );
  }

  @override
  Widget buildView([args]) {
    return this;
  }
}
