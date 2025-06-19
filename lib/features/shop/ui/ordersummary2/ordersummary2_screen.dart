import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/features/shop/ui/orderSummary/widgets/payment_method_wigets.dart';
import 'package:jappcare/features/shop/ui/ordersummary2/widgets/items_widgets.dart';
import 'controllers/ordersummary2_controller.dart';
import 'package:get/get.dart';

class Ordersummary2Screen extends GetView<Ordersummary2Controller> {
  const Ordersummary2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Order Summary',
          appBarcolor: Get.theme.scaffoldBackgroundColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ItemsWidgets(),
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: const EdgeInsets.all(10),
                child: PaymentMethodWidget(
                  buttonText: 'Place Order',
                  ontap: () {
                    controller.goToPayWithPhone();
                  },
                ))
          ],
        ),
      ),
    );
  }
}
