import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/select_vehicule_slider_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/add_image_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/boocking_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/custom_map_widget.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/estimate_inspection_fee.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/form_location_widget.dart';
import 'package:jappcare/features/workshop/ui/workshop/widgets/categories_item_list.dart';

class BookAppointmentScreen extends GetView<BookAppointmentController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Book Appointment'),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SelectedVehiculeWidget(
                  currentPage: controller.currentPage,
                  cars: controller.cars,
                  pageController: controller.pageController,
                  haveAddVehicule: false,
                  titleText: 'Selected Vehicle',
                ),
                SizedBox(height: 20,),
                SelectServiceItemList(
                  title: 'Specialized Services',),
                BookingWidget(),
                SizedBox(height: 20,),
                CustomMapWidget(),
                SizedBox(height: 20,),
                FormLocationWidget(),
                SizedBox(height: 50,),
                AddImageWidget(),

                EstimatedInspectionFee(),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                      text: 'Continue',
                      onPressed:(){
                       controller.gotToConfirmAppointment();
                      }
                  ),
                ),
                SizedBox(height: 50,),

              ],
            ),
          ) ,
          Positioned(
              top: MediaQuery.of(context).size.height*0.7,
              right: 10,
              child:Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow:[
                    BoxShadow(
                      blurRadius: 25,
                      blurStyle: BlurStyle.normal,
                      color: Colors.black,
                      offset: Offset.zero,
                      spreadRadius: 2
                    ),
                  ] ,
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Icon(FluentIcons.chat_16_filled , color: Get.theme.scaffoldBackgroundColor,size: 30,),
              )
          )
        ],
      )
     
    );
  }

}