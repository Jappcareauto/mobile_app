import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/features/shop/ui/productDetails/controllers/product_details_controller.dart';

class ProductDetailsWidget extends GetView<ProductDetailsController> {
  final String name;
  final double price;
  final String description;
  final String note;
  const ProductDetailsWidget({
    super.key,
    required this.note,
    required this.name,
    required this.price,
    required this.description,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    note,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Price
          Text(
            price.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 8),
          // Offered by
          const Text(
            'Offered by',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const Text(
            'Japcare Autotech',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          // Description
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 16),
          // Fee and Quantity Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fee',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Obx(() => Text(
                        // Formater le prix avec des séparateurs de milliers
                        "${NumberFormat('#,###').format(controller.totalPrice.value)} Frs",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ))
                ],
              ),
              // Quantity Buttons
              Row(
                children: [
                  QuantityButton(
                    icon: Icons.remove,
                    onPressed: () {
                      controller.quantity.value > 0
                          ? controller.removeQuantity(price.toDouble())
                          : null;
                    },
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        controller.quantity.value.toString(),
                        style: const TextStyle(
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

  const QuantityButton(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor.withValues(alpha: .1),
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
