import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
  final Function()? next;
  final bool haveBorder ;
  final bool? isSelected;
  final bool  hideblure ;
  final bool haveBGColor;
  final double? containerheight ;
  const CarCardAddVehicle({
    super.key,
    this.next,
    required this.haveBorder,
    this.containerheight,
    required this.hideblure,
    required this.carName,
    required this.carDetails,
    required this.imagePath,
    required this.haveBGColor,
    this.onPressed, this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerheight ,
      margin: const EdgeInsets.only(right: 12),
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color:  haveBGColor ? Get.theme.primaryColor : Get.theme.primaryColor.withOpacity(.1),
        border: haveBorder ? Border.all(color: Get.theme.primaryColor , width: 3) :  Border.all(color: AppColors.lightBorder),
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
                    Text(
                      carName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color:  haveBGColor ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(carDetails, style: TextStyle(
                      color:  haveBGColor ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14
                    ) , ),
                  ],
                ),
              ),
              if(next != null)...[
                Positioned(
                  bottom: 20,
                    left: 20,
                    child:GestureDetector(
                      onTap: next,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(right: 5),
                        child: Icon(
                          FluentIcons.arrow_right_24_regular,
                          color: haveBGColor ? Colors.white: Colors.black,
                        ),

                      ),
                    )

                )
              ],

              if(!hideblure)...[
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
              ]

            ],
          ),
        ),
      ),
    );
  }
}
