import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/ui/widgets/phone_form_field.dart';
import 'controllers/checkout_controller.dart';
import 'package:get/get.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Checkout'),
        body: SingleChildScrollView(
          child:Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Billing Details'),

                  ],
                ),
                SizedBox(height: 10,),
                Row(
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
                SizedBox(height: 10,),

                CustomFormField(

                  label: 'Town/City',
                  hintText: 'Town/City',
                ),
                SizedBox(height: 10,),

                CustomFormField(

                  label: 'Street/Address',
                  hintText: 'Street/Address',
                ),
                SizedBox(height: 10,),

                CustomPhoneFormField(
                  hintText: 'Phone',
                  label: 'Phone',
                ),
                SizedBox(height: 10,),

                CustomFormField(

                  label: 'Email',
                  hintText: 'Email',
                ),
                SizedBox(height: 100,),
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
