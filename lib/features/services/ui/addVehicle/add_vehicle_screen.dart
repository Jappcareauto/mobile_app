import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'controllers/add_vehicle_controller.dart';
import 'package:get/get.dart';

class AddVehicleScreen extends GetView<AddVehicleController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar:CustomAppBar(title: 'Add Vehicle'),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            CustomFormField(
              label: 'VIN/Chassis Number',
              hintText: 'e.g 3GCUKREC8EG359263',
            ),

            SizedBox(height: 10,),

            CustomFormField(
              label: 'License Plate Number',
              hintText: 'Ex. NW 905 AG',
            ),

            Spacer(),

            CustomButton(text: 'Add Vehicle', onPressed: (){
              controller.onpenModalPaymentMethod();
            })
          ],
        ),
      )
    );
  }
}
