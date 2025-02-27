import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/ui/widgets/phone_form_field.dart';
import 'controllers/checkout_controller.dart';
import 'package:get/get.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Checkout'),
        body: SingleChildScrollView(
          child:Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Billing Details'),

                  ],
                ),
                const SizedBox(height: 10,),
                const Row(
                  children: [

                    Expanded(child:
                    CustomFormField(

                      label: 'Fisrt Name',
                      hintText: 'First Name',
                    )),
                    SizedBox(width: 10,),
                    Expanded(child:
                    CustomFormField(

                      label: 'Last Name',
                      hintText: 'Last Name',
                    ))
                  ],
                ),
                const SizedBox(height: 10,),

                const CustomFormField(

                  label: 'Town/City',
                  hintText: 'Town/City',
                ),
                const SizedBox(height: 10,),

                const CustomFormField(

                  label: 'Street/Address',
                  hintText: 'Street/Address',
                ),
                const SizedBox(height: 10,),

                const CustomPhoneFormField(
                  hintText: 'Phone',
                  label: 'Phone',
                ),
                const SizedBox(height: 10,),

                const CustomFormField(

                  label: 'Email',
                  hintText: 'Email',
                ),
                const SizedBox(height: 100,),
                CustomButton(
                    text: 'Procced to Checkout',
                    onPressed: (){
                      controller.goToOderSummary();
                    })
              ],
            ),
          )

        )
    );
  }
}
