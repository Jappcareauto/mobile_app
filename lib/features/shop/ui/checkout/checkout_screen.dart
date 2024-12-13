import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
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
          child: Column(
            children: [
              Row(
                children: [
                  Text('Billing Details'),
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
              CustomFormField(

                label: 'Town/City',
                hintText: 'Town/City',
              ),
              CustomFormField(

                label: 'Street/Address',
                hintText: 'Street/Address',
              ),
              CustomPhoneFormField(
                hintText: 'Phone',
                label: 'Phone',
              ),
              CustomFormField(

                label: 'Email',
                hintText: 'Email',
              ),
            ],
          ),
        )
    );
  }
}
