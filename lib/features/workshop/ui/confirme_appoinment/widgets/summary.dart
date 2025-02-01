import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';
import 'package:intl/intl.dart';


class Summary extends GetView<ConfirmeAppointmentController> {
  final BookAppointmentController bookController = Get.put(
      BookAppointmentController(Get.find()));
  final images = Get.find<GlobalcontrollerWorkshop>().selectedImages;
  final argument = Get.find<GlobalcontrollerWorkshop>().workshopData;
  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(20),

        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Service Offered by',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
            Text(argument['serviceCenterName'] ?? "Unknow",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            SizedBox(height: 20,),
            Text('Items',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
            Text('Body Shop Appointment',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            SizedBox(height: 20,),
            Row(
              children: [
                if (Get.isRegistered<FeatureWidgetInterface>(
                    tag: 'AvatarWidget'))
                  Get.find<FeatureWidgetInterface>(tag: 'AvatarWidget')
                      .buildView({
                    "haveName":true
                  }),
                SizedBox(width: 10,),

               Text( Get.find<ProfileController>().userInfos?.name?? "Unknow",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(height: 20,),
            Text('Date',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
            Row(
                children: [
                  Icon(
                    FluentIcons.calendar_3_day_20_regular,

                    size: 24,
                  ),
                  Obx(() =>
                      Container(
                        child: Text(
                          DateFormat('EEE, MMM dd, yyyy').format(
                              argument['selectedDate']),
                          // Format personnalisé
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                  ),

                  SizedBox(width: 20),
                  Icon(
                    FluentIcons.clock_12_regular,

                    size: 24,

                  ),
                  Obx(() =>
                      Text(argument['selectedTime'], style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400))

                  ),
                ]
            ),
            SizedBox(height: 20,),
            argument['noteController'].isEmpty ?
            SizedBox():
            Text('Note',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
            Text(argument['noteController'],
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            SizedBox(height: 20,),
            images.isEmpty ?
            SizedBox():
            Text('Images',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
            SizedBox(height: 10,),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() =>
                    Row(
                      children: images.map((imagePath) {
                        return Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 100,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              imagePath, // Ajuster la taille de l'image
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