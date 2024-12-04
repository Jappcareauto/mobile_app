import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/autoshop_detail/controllers/autoshop_controller.dart';
import 'package:jappcare/features/workshop/ui/autoshop_detail/widgets/banner_widget.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/categories_item_list.dart';

class AutoshopScreen extends GetView<AutoShopController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              children: const [
                Icon(
                  Icons.location_on,
                  color: Colors.orange,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  'Deido, Douala',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 16),
                Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
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
            title: 'Specialized Services',
          ),
      ],
      ),
    );
  }

}