import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';

class EstimatedInspectionFee extends GetView<BookAppointmentController>{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Text('Estimated Inspection Fee', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('5,000 Frs*' , style: TextStyle(color: Get.theme.primaryColor ,fontSize: 25, fontWeight: FontWeight.bold),),

            ],
          ),
          Text('Please Note this just an estimate based in yours type of vehicule Actual price may very' , style: Get.textTheme.bodyMedium,)
        ],
      ),
    );
  }
  
}