import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_gallery.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/shop/domain/entities/cardItams.dart';
import 'package:jappcare/features/shop/ui/bag/controllers/bag_controller.dart';
import 'package:jappcare/features/shop/ui/productDetails/widgets/product_detail_widget.dart';
import 'package:jappcare/features/shop/ui/productDetails/widgets/testimoniale_widget.dart';
import 'package:jappcare/features/shop/ui/productDetails/widgets/testimonie_shimmer.dart';
import 'package:jappcare/features/shop/ui/shop/controllers/shop_controller.dart';
import 'package:jappcare/features/workshop/ui/autoshop_detail/widgets/banner_widget.dart';
import 'package:jappcare/features/workshop/ui/widgets/workshop_carrousel.dart';
import 'controllers/product_details_controller.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  final argument = Get.arguments as Map<String, dynamic>;
  final ShopController _shopController = Get.put(ShopController(Get.find()));
  final BagController bagController = Get.put(BagController(Get.find()));

  ProductDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          BannerWidget(
            imageComponents: ImageCarousel(
              positionIndicator: MainAxisAlignment.start,
              imageUrls: [argument['imagePath'] ?? AppImages.shop1],
            ),
            RightIcon: IconButton(
              icon: const Icon(FluentIcons.shopping_bag_16_regular),
              onPressed: () {
                controller.goToBag();
              },
            ),
            leftIcon: const Icon(FluentIcons.arrow_left_12_regular),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => controller.reviews != null
                ? ProductDetailsWidget(
                    note: controller
                        .calculateAverageRating(controller.reviews)
                        .toString(),
                    description: argument['description'] ?? "",
                    name: argument['name'] ?? "",
                    price: argument['price'] ?? "",
                  )
                : const SizedBox(),
          ),
          const SizedBox(
            height: 20,
          ),
          ImageGallerry(
              images: _shopController.parts.map((part) {
                return part['imagePath'];
              }),
              title: 'Product Gallery'),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => controller.loadingReview.value
                ? const TestimonieShimmer()
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (controller.reviews != null)
                          ...controller.reviews!.asMap().entries.map((review) {
                            return TestTimonialWidget(
                              name: review.key.toString(),
                              text: review.value.comment,
                              rate: review.value.rating,
                              date: DateTime.parse(review.value.createdAt),
                            );
                          }),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            text: 'Add To Bag',
            haveBorder: true,
            strech: false,
            onPressed: () {
              final newItem = CartItem(
                id: argument['productId'], // Identifiant unique du produit
                title: argument['name'],
                imageUrl: AppImages.shop1,
                price: argument['price'],
                quantity: controller.quantity.value,
              );

              // Appeler la méthode addToCart pour ajouter l'article au panier
              bagController.addToCart(newItem);
              Get.snackbar('Items Add to cart', '',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.green,
                  colorText: AppColors.white);
            },
            width: MediaQuery.of(context).size.width * .95,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            text: 'Bay Now',
            onPressed: () {},
            strech: false,
            width: MediaQuery.of(context).size.width * .95,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
