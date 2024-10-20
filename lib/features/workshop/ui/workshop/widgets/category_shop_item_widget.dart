import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/ui/widgets/image_component.dart';

class CategoryShopItemWidget extends StatelessWidget {
  final Color? color;
  final String text;
  final String imagePath;
  final double? widthContainer;
  final VoidCallback? onTap;
  final bool isSelected;

  const CategoryShopItemWidget({
    super.key,
    this.color,
    required this.text,
    required this.imagePath,
    this.onTap,
    this.widthContainer,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: isSelected
            ? Border.all(width: 1, color: Get.theme.primaryColor)
            : null,
      ),
      width: Get.width * .3,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: color ?? Get.theme.primaryColor.withOpacity(.1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 15),
                  child: Text(text),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ImageComponent(
                      assetPath: imagePath,
                      width: Get.width * .2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
