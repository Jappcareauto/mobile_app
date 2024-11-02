import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/car_container_widget.dart';
import 'package:shimmer/shimmer.dart';

class ListVehicleShimmer extends StatelessWidget {
  const ListVehicleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(.5),
        highlightColor: Colors.white,
        child: SizedBox(
          height: 190,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              const SizedBox(width: 20),
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
