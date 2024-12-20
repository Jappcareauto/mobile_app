import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/odersummary2_controller.dart';

class ItemsWidgets extends StatelessWidget {
  final Odersummary2Controller controller = Get.put(Odersummary2Controller(Get.find()));

  @override
  Widget build(BuildContext context) {
    return Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Items",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
                  () => SizedBox(
                height: 300, // Hauteur fixe pour la liste
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(), // Désactive le scroll interne
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    final item = controller.items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${item['quantity']} ${item['name']}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            "${item['price']} Frs",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold  , fontFamily: 'PlusJakarta'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20,),
            Obx(
                  () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${NumberFormat('#,###').format(controller.totalPrice)} Frs",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFB7C37)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}
