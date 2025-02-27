import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/phone_form_field.dart';
import 'controllers/checkout_phone_detail_controller.dart';
import 'package:get/get.dart';

class CheckoutPhoneDetailScreen extends GetView<CheckoutPhoneDetailController> {
  const CheckoutPhoneDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const CustomPhoneFormField(
               label: 'Phone',
              hintText: 'Phone',
            ),
            const Spacer(),

            CustomButton(text: 'Place Oder', onPressed: (){controller.goToPayWithCard();})
          ],
        ),
      ),
    );
  }
}
