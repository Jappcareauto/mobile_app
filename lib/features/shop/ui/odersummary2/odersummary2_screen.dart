import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/features/shop/ui/oderSummary/widgets/payment_methode_wigets.dart';
import 'package:jappcare/features/shop/ui/odersummary2/widgets/items_widgets.dart';
import 'controllers/odersummary2_controller.dart';
import 'package:get/get.dart';

class Odersummary2Screen extends GetView<Odersummary2Controller> {
  const Odersummary2Screen({super.key});

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
                child: PaymentMethodeWidget(
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
