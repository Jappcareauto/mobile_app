import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';

class CarContainer extends StatelessWidget {
  final String carName;
  final String carDetails;
  final String? imagePath;
  final Color principalColor;
  final Function()? onPressed;
  final bool? isSelected;

  const CarContainer({
    Key? key,
    required this.carName,
    required this.carDetails,
    this.imagePath,
    required this.principalColor,
    this.onPressed,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * .85,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        // color: isSelected != null ? null : principalColor,
        border: Border.all(
            color: isSelected == true ? principalColor : AppColors.lightBorder),
        borderRadius: BorderRadius.circular(24),
        color: Get.theme.cardColor,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              carName,
              style: TextStyle(fontSize: 20, color: Get.theme.primaryColor),
            ),
            Text(
              carDetails,
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Icon(
                    Icons.arrow_back,
                    textDirection: TextDirection.rtl,
                    color: Colors.black,
                  ),
                ),
                ImageComponent(
                  imageUrl: imagePath,
                  assetPath: AppImages.car,
                  width: Get.width * .55,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
