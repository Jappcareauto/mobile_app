import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';


class Summary extends GetView<ConfirmeAppointmentController>{
  final BookAppointmentController bookController = Get.put(BookAppointmentController(Get.find()));
  @override
  Widget build(BuildContext context) {
   return Container(
     padding: EdgeInsets.all(20),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text('Services', style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
         Text('Body Shop Appointment' ,style: TextStyle(fontSize: 20 , color: Get.theme.primaryColor)),
          SizedBox(height: 20,),
         Text('Estimated inspection Fee',  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
         Text('5,000 Frs' ,style: TextStyle(fontSize: 20 , color: Get.theme.primaryColor)),
         SizedBox(height: 20,),
         Text('Date' , style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
         Row(
           children: [
             Icon(
                 FluentIcons.calendar_3_day_20_regular,
               color: Get.theme.primaryColor,
             ),
             Obx(() =>
                 Container(
                   child: Text(
                       bookController.selectedDate.value.toString(), // Affiche la date brute
                       style: TextStyle(fontSize: 16 , color: Get.theme.primaryColor)
                   ),
                 ),
             ),

             SizedBox(width: 2),
             Icon(
               FluentIcons.clock_20_filled,
               color: Get.theme.primaryColor,
             ),
             Obx (()=>
             Text(bookController.selectedTime.value ,  style: TextStyle(fontSize: 16 , color: Get.theme.primaryColor))

           )
           ],
         )

       ],
     ),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(20),
       border: Border.all(color: Colors.grey.withOpacity(0.2))
     ),
   );
  }

}