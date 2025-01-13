import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/service_item.dart';
import 'package:shimmer/shimmer.dart';

class WorkshopShimmerWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  Shimmer.fromColors(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {

              },
              child: ServiceItemWidget(
                image: AppImages.shopCar,
                title:  'Inconnu',
                rate: '4.5',
                location: 'Douala, Cameroun',
              ),
            ),
            GestureDetector(
              onTap: () {

              },
              child: ServiceItemWidget(
                image: AppImages.shopCar,
                title:  'Inconnu',
                rate: '4.5',
                location: 'Douala, Cameroun',
              ),
            ),
          ],
        ),

        baseColor: Colors.grey.withOpacity(.5),
        highlightColor: Colors.white,
      ) ,
    );

  }

}