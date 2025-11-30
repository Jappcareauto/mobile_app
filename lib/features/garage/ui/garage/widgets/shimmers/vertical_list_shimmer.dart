import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/car_container_widget.dart';
import 'package:shimmer/shimmer.dart';

class VerticalListShimmer extends StatelessWidget {
  const VerticalListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.withValues(alpha: .5),
        highlightColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 10,
            children: <Widget>[
              CarContainer(
                carName: 'Avensis Turbo',
                carDetails: 'DW056663',
                imagePath: AppImages.car,
                principalColor: Get.theme.primaryColor,
              ),
              CarContainer(
                carName: 'Avensis Turbo',
                carDetails: 'DW056663',
                imagePath: AppImages.car,
                principalColor: Get.theme.primaryColor,
              ),
              CarContainer(
                carName: 'Avensis Turbo',
                carDetails: 'DW056663',
                imagePath: AppImages.car,
                principalColor: Get.theme.primaryColor,
              )
            ],
          ),
        ));
  }
}
