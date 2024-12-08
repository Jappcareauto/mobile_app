import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';
import 'package:intl/intl.dart';


class Summary extends GetView<ConfirmeAppointmentController>{
  final BookAppointmentController bookController = Get.put(BookAppointmentController(Get.find()));
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(20),
          
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Services',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
            Text('Body Shop Appointment',
                style: TextStyle(fontSize: 20, color: Get.theme.primaryColor)),
            SizedBox(height: 20,),
            Text('Estimated inspection Fee',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
            Text('5,000 Frs',
                style: TextStyle(fontSize: 20, color: Get.theme.primaryColor)),
            SizedBox(height: 20,),
            Text('Date',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
            Row(
                children: [
                  Icon(
                    FluentIcons.calendar_3_day_20_regular,
                    color: Get.theme.primaryColor,
                  ),
                  Obx(() =>
                      Container(
                        child: Text(
                          DateFormat('EEE, MMM dd, yyyy').format(
                              bookController.selectedDate.value),
                          // Format personnalisé
                          style: TextStyle(
                            fontSize: 16,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ),
                  ),

                  SizedBox(width: 20),
                  Icon(
                    FluentIcons.clock_12_regular,
                    color: Get.theme.primaryColor,
                  ),
                  Obx(() =>
                      Text(bookController.selectedTime.value, style: TextStyle(
                          fontSize: 16, color: Get.theme.primaryColor))

                  ),
                ]
            ),
            SizedBox(height: 20,),
            Text('Note',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
            Text('Iwould like to fix a dent in my front bumper',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            SizedBox(height: 20,),
            Text('Note',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
            SizedBox(height: 10,),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() =>
                    Row(
                      children: bookController.images.map((imagePath) {
                        return Container(
                          margin: EdgeInsets.only(right: 20),
                          // Espacement entre les images
                          height: 100,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                )
            )

          ],
        ));
  }
}