import 'package:flutter/material.dart';
import 'package:jappcare/core/services/form/validators.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/custom_text_field.dart';
import 'package:jappcare/core/ui/widgets/select_vehicule_slider_widget.dart';
import 'package:jappcare/features/emergency/domain/entities/emergency.dart';
import 'package:jappcare/features/emergency/ui/emergency/controllers/emergency_controller.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
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
        Form(
          key: controller.formKey,
          child:
        Column(
          children: [
            SizedBox(height: 20,),
            if (Get.isRegistered<FeatureWidgetInterface>(
                tag: 'ListVehicleWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'ListVehicleWidget')
                  .buildView({
                "pageController": generateVehiculeReportController.pageController ,
                "currentPage": generateVehiculeReportController.currentPage,
                "haveAddVehicule": true,
                "title": "My Garage",
                "onSelected" : (Vehicle selectedVehicle){
                      controller.selectedVehicleName.value = selectedVehicle.name ;
                      controller.selectedVehiculeUrl.value = selectedVehicle.imageUrl;
                      controller.selectedVehiculeId.value = selectedVehicle.id ;

                },
                "onTapeAddVehicle": (){
                  print("clique");
                },
              }),
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
                controller: controller.noteController,
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
            // CustomMapWidget(),
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
                validator: Validators.requiredField,
                controller: controller.locationController,
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
                  AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                  curve: Curves.linear,
                  child:
                  Switch(
                    value: controller.savePhoneNumberPaymentMethod.value,
                    onChanged: (value) {
                      print('la valeur du switch:$value');
                      controller.savePhoneNumberPaymentMethod.value = value ;
                    },
                    activeColor:Get.theme.primaryColor,

                  ),
                  )

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
                  isLoading : controller.loading ,
                  onPressed: (){
                    if(controller.formKey.currentState?.validate() ?? false){
                      controller.emergencyAssistance(
                          emergencyController.selectedCategorie.value,
                          Location.create(
                              latitude: controller.userLocation.value!.latitude,
                              longitude: controller.userLocation.value!.longitude,
                              description: controller.noteController.text ,
                              createdBy:  Get.find<ProfileController>().userInfos!.id,
                              updatedBy:  Get.find<ProfileController>().userInfos!.id,
                              createdAt: DateTime.now().toUtc().toIso8601String(),
                              updatedAt: DateTime.now().toUtc().toIso8601String()
                          ),
                              // 'servicesCenterId',
                              controller.selectedVehiculeId.value,
                              emergencyController.selectedCategorie.value,
                              controller.noteController.text,
                              "REQUESTED",
                              Get.find<ProfileController>().userInfos!.id,
                              Get.find<ProfileController>().userInfos!.id
                      );
                    }

                  }),
            )

          ],
        ),
    )
      )
    );
  }
}
