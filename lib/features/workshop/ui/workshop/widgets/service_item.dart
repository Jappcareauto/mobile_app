import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/ui/widgets/image_component.dart';

class ServiceItemWidget extends StatelessWidget {
  final String title;
  final String rate;
  final String image;
  final String location;
  final void Function()? onTap;
  const ServiceItemWidget(
      {super.key,
      this.onTap,
      required this.title,
      required this.rate,
      required this.image,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        splashColor: Get.theme.primaryColor.withValues(alpha: 0.2),
        highlightColor: Get.theme.primaryColor.withValues(alpha: 0.1),
        child: Card(
          elevation: .0,
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                ImageComponent(
                  assetPath: image,
                  height: 200,
                  width: Get.width,
                  borderRadius: 12,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(title, style: Get.textTheme.bodyLarge),
                    const SizedBox(width: 10),
                    Icon(FluentIcons.star_24_filled,
                        color: Get.theme.primaryColor, size: 18),
                    Text(rate,
                        style: Get.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.normal,
                            color: Get.theme.primaryColor)),
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
                            child: Text(location,
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
      ),
    );
  }
}
