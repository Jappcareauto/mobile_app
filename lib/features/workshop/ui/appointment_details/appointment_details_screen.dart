import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_colors.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/home/ui/home/widgets/notification_widget.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/controllers/appointment_details_controller.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/widgets/expendend_container_widget.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/widgets/invoices_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';

class AppointmentDetailScreen extends GetView<AppointmentDetailsController>{
  final BookAppointmentController bookController = Get.put(BookAppointmentController(Get.find()));
  // final ConfirmeAppointmentController confirmAppointment = Get.put(ConfirmeAppointmentController(Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Appointment \n Details'),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        'Porsch Taycan Turbo S' ,
                        style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 22 , color: Color(0xFFFB7C37))
                      ),
                      Text('2024 , RWD'),
                    ],
                  )
                ],
              ),

              SizedBox(height: 20,),

                  ImageComponent(
                    assetPath: AppImages.carWhite,
                  ),



              NotificationWidget(
                backgrounColor: Get.theme.primaryColor.withOpacity(.2),
                  bodyText: 'Your repair from the Japcare Autotech shop is ready, and available for pickup',
                  coloriage: Get.theme.primaryColor,
                  icon: FluentIcons.alert_12_regular,
                  title: 'Notification'),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    child: Row(

                      children: [
                        SizedBox(width: 5,),
                        CircleAvatar(

                          backgroundImage: AssetImage(AppImages.avatar),
                        ),
                        const SizedBox(width:5),

                        Text('Japtech AutoShop'),

                      ],
                    ),
                  ) ,
                  SizedBox(height: 20,),

                  Container(

                    padding: EdgeInsets.all(10),
                    child: Text('In Progress' , style: TextStyle(color: Get.theme.primaryColor),),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                        color: Get.theme.primaryColor.withOpacity(.2)),
                  )
                ],
              ),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Body shop appointment'
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                  children: [
                    Icon(
                      FluentIcons.calendar_3_day_20_regular,

                    ),

                    Container(
                      child: Text(
                        DateFormat('EEE, MMM dd, yyyy').format(
                            bookController.selectedDate.value),
                        // Format personnalisé
                        style: TextStyle(
                          fontSize: 14,

                        ),
                      ),
                    ),


                    SizedBox(width: 40),
                    Icon(
                      FluentIcons.location_12_regular,

                    ),

                    Text(
                        bookController.selectedLocation.value, style: TextStyle(
                        fontSize: 14,fontWeight: FontWeight.w300 ))

                  ]
              ),
              SizedBox(height: 20,),
              ExpandableContainer(
                onpresse: (){
                  controller.toggleExpanded();
                },
                visibility: controller.isExpanded,
              subtitle:Text(
                  "Reported Issue",
                  style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.5,
                      color: Colors.grey
                  ),
                ),
                title: "Reported Issue",
                description:
                "There is a noticeable dent on the rear bumper of my Porsche Taycan, specifically located between the lower edge of the rear headlight and the rear wheel arch. It is closer to the wheel arch, situated near the car's side profile. The dent is below the horizontal line of the rear headlight and sits closer to the lower third of the rear bumper.",
                imageUrls:bookController.images,
                controller: controller,
              ),
              SizedBox(height: 20,),
              ExpandableContainer(
                onpresse: (){
                  controller.toggleisExpandedReportDetail();
                },
                visibility: controller.isExpandedReportDetail,
                subtitle:Text("Diagnosed Issue & Repairs to be made" , style: TextStyle(color: Get.theme.primaryColor)) ,
                title: "Reported Details",
                description:
                "There is a noticeable dent on the rear bumper of my Porsche Taycan, specifically located between the lower edge of the rear headlight and the rear wheel arch. It is closer to the wheel arch, situated near the car's side profile. The dent is below the horizontal line of the rear headlight and sits closer to the lower third of the rear bumper.",
                imageUrls:[],
                controller: controller,
              ),
              SizedBox(height: 20,),
              Obx(()=>
              Visibility(
                visible: controller.isExpandedReportDetail.value,
                child:
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        border: Border.all(color:Colors.grey.withOpacity(.2) ,  width: 1),
                        borderRadius: BorderRadius.circular(20)
                    ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text('Repaire made' , style: TextStyle(color: Get.theme.primaryColor),),
                          Text(
                              'We fixed the rear bumper by hammering out the dent, and applied a new coat of body paint protection. '
                          )
                        ],
                      )
                  ),
                 ),
              ),
              SizedBox(height: 20,),

              InvoiceDetails(
                  items: controller.invoiceItems,
                  total: 50500,
                  tax: 2500,
                  amount: 54000
              ),
              SizedBox(height: 20,),

              CustomButton(
                  text: 'Pay Invoice',
                  onPressed: (){
                    controller.goToInvoice();
              }),
              SizedBox(height: 50,)
            ],
          ),
        ) ,
      )
     ,
    );


  }

}