import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/ui/widgets/image_gallery.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/garage/ui/garage/widgets/shimmers/list_vehicle_shimmer.dart';
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
  final argument = Get.arguments as Map<String , dynamic> ;
  final ShopController _shopController = Get.put(ShopController(Get.find()));
  final BagController bagController  = Get.put(BagController(Get.find()));
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerWidget(
              imageComponents: ImageCarousel(
                positionIndicator: MainAxisAlignment.start,
                imageUrls: [
                  argument['imagePath'] ?? AppImages.shop1
                ],
              ),
              RightIcon: IconButton(
                icon:Icon(FluentIcons.shopping_bag_16_regular) ,
                onPressed: (){
                  controller.goToBag();
                },),
              leftIcon: Icon(FluentIcons.arrow_left_12_regular),
            ),
            SizedBox(height: 20,),
            Obx(() =>
              controller.reviews?.value != null ?
              ProductDetailsWidget(
                note: controller.calculateAverageRating(controller.reviews).toString(),
                description: argument['description'] ?? "",
                name: argument['name'] ?? "",
                price: argument['price'] ?? "",
              ):
              SizedBox(),
            ),
            SizedBox(height: 20,),
            ImageGallerry(
                images: _shopController.parts.map((part){ return part['imagePath'] ;}),
                title: 'Product Gallery'
            ),
            SizedBox(height: 20,),
            Obx(() =>
                controller.loadingReview.value ?
                TestimonieShimmer() :
                SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if(controller.reviews?.value != null)
                  ...controller.reviews!.value.asMap().entries.map((review){
                      return TestTimonialWidget(
                        name: review.key.toString(),
                        text: review.value.comment,
                        rate: review.value.rating,
                        date:DateTime.parse(review.value.createdAt),
                      );
                  }).toList(),
                  SizedBox(width: 16,),

                ],
              ),
            ),
    ),
            SizedBox(height: 20,),
            CustomButton(
                text: 'Add To Bag',
                haveBorder: true,
                strech: false,

                onPressed: (){

                    final newItem = CartItem(
                      id: argument['productId'], // Identifiant unique du produit
                      title: argument['name'],
                      imageUrl: AppImages.shop1,
                      price: argument['price'],
                      quantity: controller.quantity.value,
                    );

                    // Appeler la méthode addToCart pour ajouter l'article au panier
                    bagController.addToCart(newItem);
                    Get.snackbar('Items Add to cart', '', snackPosition: SnackPosition.BOTTOM , backgroundColor: AppColors.green , colorText: AppColors.white);

                },
                width: MediaQuery.of(context).size.width*.95,
            ),
            SizedBox(height: 20,),
            CustomButton(
              text: 'Bay Now',
              onPressed: (){},
              strech: false,
              width: MediaQuery.of(context).size.width*.95,
            ),
            SizedBox(height: 20,),

          ],
        ),
      )
    );
  }
}
