import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ServiceItemShimmer extends StatelessWidget {
  const ServiceItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withValues(alpha: .5),
      highlightColor: Colors.white,
      child: Card(
          elevation: .0,
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              spacing: 4,
              children: [
                Container(
                  height: 200,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                  ),
                ),
                // const SizedBox(height: 4),
                Row(
                  children: [
                    Text("Loading...", style: Get.textTheme.bodyLarge),
                    const SizedBox(width: 10),
                    Icon(FluentIcons.star_24_filled,
                        color: Get.theme.primaryColor, size: 18),
                    // Text("Loading...",
                    //     style: Get.textTheme.bodyLarge?.copyWith(
                    //         fontWeight: FontWeight.normal,
                    //         color: Get.theme.primaryColor)),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(FluentIcons.location_24_regular,
                              color: Get.theme.primaryColor, size: 18),
                          Flexible(
                            child: Text("loading...",
                                style: Get.textTheme.bodyMedium
                                    ?.copyWith(color: Get.theme.primaryColor)),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "View Details",
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(color: Get.theme.primaryColor),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
}