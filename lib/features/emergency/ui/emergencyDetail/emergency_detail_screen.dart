import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/ui/widgets/select_vehicule_slider_widget.dart';
import 'package:jappcare/features/emergency/ui/emergency/controllers/emergency_controller.dart';
import 'package:jappcare/features/services/ui/generateVehiculeReport/controllers/generate_vehicule_report_controller.dart';
import 'package:jappcare/features/shop/ui/shop/widgets/tabs_list_widgets.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/widgets/custom_map_widget.dart';
import 'controllers/emergency_detail_controller.dart';
import 'package:get/get.dart';

class EmergencyDetailScreen extends GetView<EmergencyDetailController> {
  final GenerateVehiculeReportController generateVehiculeReportController = Get.put(GenerateVehiculeReportController(Get.find()));
  final EmergencyController emergencyController = Get.put(EmergencyController(Get.find()));
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar:CustomAppBar(title: 'Emergency\nAssistance'),
      body:  SingleChildScrollView(
        child:
        Column(
          children: [
            SizedBox(height: 20,),
            SelectedVehiculeWidget(
                pageController: generateVehiculeReportController.pageController,
                cars: generateVehiculeReportController.vehicleList,
                currentPage: generateVehiculeReportController.currentPage,
                haveAddVehicule: false,
                titleText: 'Select Vehicle'
            ),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.only(left: 20),
              child:  Row(
                children: [
                  Text(
                    'What is your emergency',
                      style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 16),
                  ),
                ],
              ),
            ),

            TabsListWidgets(
                tabs: emergencyController.categorie, 
                selectedFilter: emergencyController.selectedindex, 
                selectedTabs: emergencyController.selectedCategorie, 
                borderRadius: BorderRadius.circular(16),
                haveBorder: true
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),

              child: CustomFormField(
                maxLine: 8,
                hintText: 'Add a Note (Optional)',
              ) ,
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 20),
              child:  Row(
                children: [
                  Text(
                    'Live Location',
                    style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 16),

                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            CustomMapWidget(),
            SizedBox(height: 10,),

            Container(
              margin: EdgeInsets.only(left: 20),
              child:  Row(
                children: [
                  Text(
                    'Location',
                    style: TextStyle(fontWeight: FontWeight.w400 , fontSize: 14),

                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),

              child:  CustomFormField(

                hintText: 'Search for a place',
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Share Live Location?",
                    style: TextStyle(fontWeight: FontWeight.w400 , fontSize: 14),

                  ),
                  Obx(() =>
                      Switch(
                        value: controller.savePhoneNumberPaymentMethod.value,
                        onChanged: (value) {
                          print('la valeur du switch:$value');
                          controller.savePhoneNumberPaymentMethod.value = value ;
                        },
                        activeColor:Get.theme.primaryColor,

                      ),
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 20,
                bottom: 50
              ),
              child: CustomButton(
                  text: 'Send Request',
                  onPressed: (){
                      controller.goToWaitResponse();
                  }),
            )

          ],
        ),
      )
    );
  }
}
