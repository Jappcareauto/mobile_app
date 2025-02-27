import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/ui/widgets/phone_form_field.dart';
import 'controllers/checkout_card_details_controller.dart';
import 'package:get/get.dart';

class CheckoutCardDetailsScreen extends GetView<CheckoutCardDetailsController> {
  const CheckoutCardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Card Number
            const CustomFormField(
              hintText: 'Card Number',
              label: 'Card Number',
            ),
            const SizedBox(height: 16),

            // Expiry Date et CVC
            const Row(
              children: [
                Expanded(
                  child: CustomFormField(
                    hintText: 'MM/YY',
                    label: 'Expiry',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomFormField(
                    hintText: 'CVC',
                    label: 'CVC',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Phone Field
            const CustomPhoneFormField(
              label: 'Phone',
              hintText: 'Phone',
            ),
            const SizedBox(height: 16),

            // Adresse
            const CustomFormField(
              hintText: 'Address',
              label: 'Address',
            ),
            const SizedBox(height: 24),

            // Bouton
            Center(
              child: CustomButton(
                text: 'Place Order',
                onPressed: () {
                 controller.goToConfirmTransaction();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
