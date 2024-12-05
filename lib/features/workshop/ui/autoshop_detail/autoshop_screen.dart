import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/features/workshop/ui/autoshop_detail/controllers/autoshop_controller.dart';
import 'package:jappcare/features/workshop/ui/autoshop_detail/widgets/banner_widget.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/categories_item_list.dart';

class AutoshopScreen extends GetView<AutoShopController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:

      Column(
        children: [
          BannerWidget(),
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,


        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Japtech Autoshop',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Available',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  FluentIcons.location_12_regular,
                  color: Get.theme.primaryColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                const Text(
                  'Deido, Douala',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 16),
                 Icon(
                  FluentIcons.star_16_filled,
                  color: Get.theme.primaryColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                const Text(
                  '4.75',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Experience top-notch service at Japtech Auto shop, where we offer a wide range of basic car services to keep your vehicle running smoothly.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
          SelectServiceItemList(
            title: 'Specialized Services',),
          SizedBox(height: 20,),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Get.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),

            ),
            child: Placeholder(),
          ),
          SizedBox(height: 20,),
          Container(
             margin: EdgeInsets.symmetric(horizontal: 10),
            child:   CustomButton(
                text: 'Book Appointment',
                isLoading: controller.isLoading,
                onPressed: (){
                  controller.gotoBoockApontment();
                }),
          ),

          SizedBox(height: 30,)
      ],
      ),
      )
    );
  }

}