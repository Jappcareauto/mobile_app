import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/shop/ui/shop/controllers/shop_controller.dart';

import '../../../../../core/utils/app_images.dart';
import 'category_shop_item_widget.dart';

class CategoriesItemList extends StatelessWidget {
  const CategoriesItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text("Category", style: Get.textTheme.bodyLarge),
        ),
        const SizedBox(height: 10),
        SizedBox(
            height: 150,
            width: Get.width,
            child: MixinBuilder<ShopController>(
              builder: (_) {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 20),
                    CategoryShopItemWidget(
                        onTap: () => _.selectedCategoryIndex.value = 0,
                        isSelected: _.selectedCategoryIndex.value == 0,
                        text: 'General Maintenance',
                        imagePath: AppImages.maintenance),
                    CategoryShopItemWidget(
                      onTap: () => _.selectedCategoryIndex.value = 1,
                      text: 'Body Shop',
                      imagePath: AppImages.carBody,
                      isSelected: _.selectedCategoryIndex.value == 1,
                    ),
                    CategoryShopItemWidget(
                      isSelected: _.selectedCategoryIndex.value == 2,
                      onTap: () => _.selectedCategoryIndex.value = 2,
                      text: 'Deep Cleaning',
                      imagePath: AppImages.carClean,
                    )
                  ],
                );
              },
            )),
      ],
    );
  }
}
