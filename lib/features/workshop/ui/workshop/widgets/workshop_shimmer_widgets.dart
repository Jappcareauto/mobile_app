import 'package:flutter/material.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/service_item.dart';
import 'package:shimmer/shimmer.dart';

class WorkshopShimmerWidgets extends StatelessWidget {
  const WorkshopShimmerWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withValues(alpha: .5),
        highlightColor: Colors.white,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: const ServiceItemWidget(
                image: AppImages.shopCar,
                title: 'Inconnu',
                rate: '4.5',
                location: 'Douala, Cameroun',
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const ServiceItemWidget(
                image: AppImages.shopCar,
                title: 'Inconnu',
                rate: '4.5',
                location: 'Douala, Cameroun',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
