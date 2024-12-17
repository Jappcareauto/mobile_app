import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/phone_form_field.dart';
import 'controllers/checkout_phone_detail_controller.dart';
import 'package:get/get.dart';

class CheckoutPhoneDetailScreen extends GetView<CheckoutPhoneDetailController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(title: 'Checkout'),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            CustomPhoneFormField(
               label: 'Phone',
              hintText: 'Phone',
            ),
            Spacer(),

            CustomButton(text: 'Place Oder', onPressed: (){controller.goToPayWithCard();})
          ],
        ),
      ),
    );
  }
}
