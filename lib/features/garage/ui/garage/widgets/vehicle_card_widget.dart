import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';

class VehicleCardWidget extends StatelessWidget {
  final String carName;
  final List<String> carDetails;
  final String? imagePath;
  final String? imageUrl;

  final Function()? onPressed;
  final bool? isSelected;
  final bool? showDelete;
  final bool haveBGColor;
  final bool haveBorder;

  final double? containerheight;
  const VehicleCardWidget({
    super.key,
    required this.haveBorder,
    this.imageUrl,
    this.containerheight,
    this.showDelete,
    required this.carName,
    required this.carDetails,
    this.imagePath,
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
            ? Border.all(color: Get.theme.primaryColor, width: 2)
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
              if (imageUrl != null)
                ImageComponent(
                  assetPath: imageUrl == null ? imagePath : "",
                  imageUrl: imageUrl,
                  width: 200,
                  height: 120,
                ),
              Positioned(
                top: 8,
                left: 8,
                right: 0,
                child: SizedBox(
                  width: Get.width,
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
                              color: haveBGColor
                                  ? Colors.white
                                  : Get.theme.primaryColor,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
