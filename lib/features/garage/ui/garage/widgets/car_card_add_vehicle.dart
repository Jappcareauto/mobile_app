import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';

class CarCardAddVehicle extends StatelessWidget {
  final String carName;
  final List<String> carDetails;
  final String imagePath;
  final String? imageUrl;

  final Function()? onPressed;
  final Function()? next;
  final Function()? delete;
  final bool haveBorder;
  final bool? isSelected;
  final bool? showDelete;
  final bool hideblure;
  final bool haveBGColor;

  final double? containerheight;
  const CarCardAddVehicle({
    super.key,
    this.next,
    this.delete,
    this.imageUrl,
    required this.haveBorder,
    this.containerheight,
    this.showDelete,
    required this.hideblure,
    required this.carName,
    required this.carDetails,
    required this.imagePath,
    required this.haveBGColor,
    this.onPressed,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerheight,
      margin: const EdgeInsets.only(right: 12),
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: haveBGColor ? Get.theme.primaryColor : AppColors.white,
        border: haveBorder
            ? Border.all(color: Get.theme.primaryColor, width: 1)
            : Border.all(color: AppColors.lightBorder),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              ImageComponent(
                assetPath: imageUrl == null ? imagePath : "",
                // imageUrl: imageUrl,
                imageUrl:
                    "https://vhr.nyc3.cdn.digitaloceanspaces.com/vehiclemedia/gallery/2005/gmc/sierra-1500/sle-4x2-crew-cab-5.75-ft.-box-143.5-in.-wb-automatic/ext-6130313031.jpg",
                width: 250,
                height: 120,
              ),
              Positioned(
                top: 8,
                left: 8,
                right: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${carDetails[1]} $carName",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: haveBGColor ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            "${carDetails[0]}, ${carDetails[1]}",
                            style: TextStyle(
                                color:
                                    haveBGColor ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      if (showDelete == true) ...{
                        Ink(
                          color: Colors.grey,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: delete,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(right: 5),
                              child: Icon(
                                FluentIcons.delete_24_regular,
                                color:
                                    haveBGColor ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        )
                      },
                    ],
                  ),
                ),
              ),
              if (next != null) ...[
                Positioned(
                    bottom: 8,
                    left: 8,
                    child: GestureDetector(
                      onTap: next,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(right: 5),
                        child: Icon(
                          FluentIcons.arrow_right_24_regular,
                          color: haveBGColor ? Colors.white : Colors.black,
                        ),
                      ),
                    ))
              ],
              if (!hideblure) ...[
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  top: 0,
                  left: 16,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '+ Add Vehicle',
                            style: Get.textTheme.bodyLarge?.copyWith(
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
