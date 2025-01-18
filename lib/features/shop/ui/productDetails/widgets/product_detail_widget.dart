import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/features/shop/ui/productDetails/controllers/product_details_controller.dart';
import 'package:jappcare/features/shop/ui/shop/controllers/shop_controller.dart';

class ProductDetailsWidget extends GetView<ProductDetailsController> {
  final String name  ;
  final double price ;
  final String description ;
  ProductDetailsWidget({
    Key?key,
    required this.name,
    required this.price,
    required this.description,
}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Rating Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '4.75',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            // Price
            Text(
              price.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 8),
            // Offered by
            Text(
              'Offered by',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              'Japcare Autotech',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16),
            // Fee and Quantity Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fee',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Obx(() =>
                        Text(
                          // Formater le prix avec des séparateurs de milliers
                          "${NumberFormat('#,###').format(controller.totalPrice.value)} Frs",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    )
                    )
                  ],
                ),
                // Quantity Buttons
                Row(
                  children: [

                    QuantityButton(
                      icon: Icons.remove,
                      onPressed: () {
                        controller.quantity.value > 0 ?
                        controller.removeQuantity(price.toDouble()):
                          null
                        ;

                      },
                    ),
                    Obx(() =>

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        controller.quantity.value.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ),
                    QuantityButton(
                      icon: Icons.add,
                      onPressed: () {
                        controller.addQuantity(price.toDouble());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

  }
}

class QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  QuantityButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          size: 16,
          color: Colors.black,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
