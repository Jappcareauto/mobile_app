import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/controllers/services_locator_controller.dart';

import '../../../../../core/ui/widgets/image_component.dart';
class ServiceWidget extends GetView<ServicesLocatorController> {
  final String title;
  final String rate;
  final String image;
  final String location;
  final VoidCallback? onTap;
  final bool ishide; // Changement ici

  const ServiceWidget({
    super.key,
    this.onTap,
    required this.ishide,
    required this.title,
    required this.rate,
    required this.image,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return
        Container(
        margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              ImageComponent(
                assetPath: image,
                height: 200,
                width: Get.width,
                borderRadius: 12,
              ),
              if (ishide) ...[
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
                  children: [
                    Icon(FluentIcons.location_24_regular,
                        color: Get.theme.primaryColor, size: 18),
                    Expanded(
                      child: Text(location,
                          style: Get.textTheme.bodyMedium
                              ?.copyWith(color: Get.theme.primaryColor)),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        "View Details",
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(color: Get.theme.primaryColor),
                      ),
                    )

                  ],
                ),
              ],
            ],
          ),
        );

  }
}
