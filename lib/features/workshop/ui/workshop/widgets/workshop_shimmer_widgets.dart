import 'package:flutter/material.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/shimmers/service_item_shimmer.dart';
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
            ServiceItemShimmer(),
            ServiceItemShimmer(),
            ServiceItemShimmer(),
          ],
        ),
      ),
    );
  }
}
