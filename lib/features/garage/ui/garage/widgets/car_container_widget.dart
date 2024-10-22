import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarContainer extends StatelessWidget {
  final String carName;
  final String carDetails;
  final String imagePath;
  final Color principalColor;
  final Function()? onPressed;
  final bool? isSelected;

  const CarContainer({
    Key? key,
    required this.carName,
    required this.carDetails,
    required this.imagePath,
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
        color: isSelected != null ? null : principalColor,
        border: isSelected == true ? Border.all(color: principalColor) : null,
        borderRadius: BorderRadius.circular(24),
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
              style: TextStyle(
                  fontSize: 20,
                  color: isSelected != null ? null : Colors.white),
            ),
            Text(
              carDetails,
              style: TextStyle(
                  fontSize: 14,
                  color: isSelected != null ? null : Colors.white70),
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
                    color: isSelected != null ? null : Colors.white,
                  ),
                ),
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: Get.width * .58,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
