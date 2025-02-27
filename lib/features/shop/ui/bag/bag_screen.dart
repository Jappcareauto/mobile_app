import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/shop/ui/bag/widgets/items_widgets.dart';
import 'controllers/bag_controller.dart';
import 'package:get/get.dart';

class BagScreen extends GetView<BagController> {
  // @override
  final BagController cartController = Get.put(BagController(Get.find()));

  BagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Bag'),
        body: controller.cartItems.isEmpty
            ? const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text('Votre Panier est vide')],
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Liste des articles
                      Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartController.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartController.cartItems[index];
                            return ItemContainer(
                              assetPath: '',
                              total: controller.totalPrices.value.obs,
                              imageUrl: item.imageUrl,
                              title: item.title,
                              price: item.price.toInt(),
                              quantity: item.quantity.obs,
                              onDelete: () {
                                controller.showDeleteModal(item.id);
                              },
                              onIncrement: () => cartController.updateQuantity(
                                  item.id, item.quantity + 1),
                              onDecrement: () => cartController.updateQuantity(
                                  item.id, item.quantity - 1),
                              modifyQuantity: true,
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 16),
                      // Champ de saisie du coupon

                      Column(
                        children: [
                          Container(
                              child: const Row(
                            children: [Text('Coupon code')],
                          )),
                          Row(
                            children: [
                              const Expanded(
                                child: CustomFormField(
                                  filColor: AppColors.white,
                                  hintText: 'Code',
                                  borderColor: Color(0xFFE5E2E1),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CustomButton(
                                  text: 'Apply Coupon',
                                  strech: false,
                                  haveBorder: true,
                                  borderRadius: BorderRadius.circular(30),
                                  width: MediaQuery.of(context).size.width * .4,
                                  onPressed: () {})
                            ],
                          ),
                          const SizedBox(
                            height: 200,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF797676),
                                    fontFamily: 'PlusJakartaSans'),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .5,
                              ),
                              Expanded(
                                  child: Text(
                                "${NumberFormat('#,###').format(controller.totalPrices.value)} Frs",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Get.theme.primaryColor),
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                              text: 'Procced Checkout',
                              strech: false,
                              width: MediaQuery.of(context).size.width * .95,
                              onPressed: () {
                                controller.goToCheckout();
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              text: 'Continue Shopping',
                              strech: false,
                              haveBorder: true,
                              width: MediaQuery.of(context).size.width * .95,
                              onPressed: () {})
                        ],
                      ),
                    ],
                  ),
                ),
              ));
  }
}
