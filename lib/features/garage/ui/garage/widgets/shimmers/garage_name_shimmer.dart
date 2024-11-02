import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class MyGarageNameShimmer extends StatelessWidget {
  const MyGarageNameShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Text('My Garage', style: Get.textTheme.bodyLarge),
    );
  }
}
