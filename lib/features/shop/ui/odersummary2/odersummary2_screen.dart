import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/features/shop/ui/oderSummary/widgets/payment_methode_wigets.dart';
import 'package:jappcare/features/shop/ui/odersummary2/widgets/items_widgets.dart';
import 'controllers/odersummary2_controller.dart';
import 'package:get/get.dart';

class Odersummary2Screen extends GetView<Odersummary2Controller> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(title: 'Oder Summary'),
      body:  SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ItemsWidgets(),

              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.all(10),
              child: PaymentMethodeWidget(buttonText: 'Place Oder', ontap: (){controller.goToPayWithPhone();},)


              )
            ],
          ),
        ),
      )
    );
  }
}
