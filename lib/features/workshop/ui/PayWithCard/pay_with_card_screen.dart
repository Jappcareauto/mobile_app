import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/features/workshop/ui/PayWithCard/controllers/pay_with_card_controller.dart';

class PayWithCardScreen extends GetView<PayWithCardController> {
  const PayWithCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarcolor: Get.theme.scaffoldBackgroundColor,
        title: 'Card Details',
        actions: [
          if (Get.isRegistered<FeatureWidgetInterface>(tag: 'AvatarWidget'))
            Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget').buildView(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Montant
              const Center(
                child: Text(
                  "You are about to make a payment of",
                  style: TextStyle(fontSize: 16.0, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  "5000 Frs",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Champ Card Number
              const CustomFormField(
                hintText: 'Card Number',
                label: 'Card Number',
              ),
              const SizedBox(height: 16),
              // Expiry et CVC
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
              // Adresse
              const CustomFormField(
                hintText: 'Adress',
                label: 'Adress',
              ),
              const SizedBox(height: 20),
              // Switch pour sauvegarder la carte
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Save Card as Payment Method",
                    style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  ),
                  Obx(
                    () => Switch(
                      value: controller.saveCardPaymentMethode.value,
                      onChanged: (value) {
                        print('la valeur du switch:$value');
                        controller.saveCardPaymentMethode.value = value;
                      },
                      activeColor: Get.theme.primaryColor,
                    ),
                  )
                ],
              ),
              const Spacer(),
              // Boutons
              Column(
                children: [
                  CustomButton(
                    text: 'Change Payment Method',
                    onPressed: () {},
                    haveBorder: true,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Proceed to Payment',
                    onPressed: () => controller.gotToSuccessPayment(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
