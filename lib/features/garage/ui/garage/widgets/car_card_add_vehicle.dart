import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';

class CarCardAddVehicle extends StatelessWidget {
  final String carName;
  final String carDetails;
  final String imagePath;
  final Function()? onPressed;
  final bool? isSelected;

  const CarCardAddVehicle({
    super.key,
    required this.carName,
    required this.carDetails,
    required this.imagePath,
    this.onPressed, this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Get.theme.primaryColor.withOpacity(.1),
        border: Border.all(color: AppColors.lightBorder),
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
                assetPath: imagePath,
                width: 250,
                height: 120,
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Porsche 911 GT3RS',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('2024, RWD', style: Get.textTheme.bodyMedium),
                  ],
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
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
                    SizedBox(height: 8),
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
            ],
          ),
        ),
      ),
    );
  }
}
