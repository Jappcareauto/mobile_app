import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/ui/widgets/image_gallery.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/shop/ui/productDetails/widgets/product_detail_widget.dart';
import 'package:jappcare/features/shop/ui/productDetails/widgets/testimoniale_widget.dart';
import 'package:jappcare/features/shop/ui/shop/controllers/shop_controller.dart';
import 'package:jappcare/features/workshop/ui/autoshop_detail/widgets/banner_widget.dart';
import 'package:jappcare/features/workshop/ui/widgets/workshop_carrousel.dart';
import 'controllers/product_details_controller.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  final argument = Get.arguments as Map<String , dynamic> ;
  final ShopController _shopController = Get.put(ShopController(Get.find()));

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerWidget(
              imageComponents: ImageCarousel(
                imageUrls: [
                  argument['imagePath']
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
            ProductDetailsWidget(
              description: argument['description'],
              name: argument['name'],
              price: argument['price'],
            ),
            SizedBox(height: 20,),
            ImageGallerry(
                images: _shopController.parts.map((part){ return part['imagePath'] ;}),
                title: 'Product Gallery'
            ),
            SizedBox(height: 20,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(

                children: [
                  TestTimonialWidget(
                    name: 'Donal',
                    text: 'These headlights look absolutely amazing! Recommend this product 100%',
                    rate: 4,
                    date: DateTime.now(),
                  ),
                  SizedBox(width: 16,),
                  TestTimonialWidget(
                    name: 'Donal',
                    text: 'These headlights look absolutely amazing! Recommend this product 100%',
                    rate: 4,
                    date: DateTime.now(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            CustomButton(
                text: 'Add To Bag',
                haveBorder: true,
                strech: false,

                onPressed: (){},
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
