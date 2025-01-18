import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/select_vehicule_slider_widget.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'controllers/generate_vehicule_report_controller.dart';
import 'package:get/get.dart';

class GenerateVehiculeReportScreen extends GetView<GenerateVehiculeReportController> {
  @override
  final GarageController garageController = GarageController(Get.find(), Get.find());
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(title: 'Generate \n Vehicule Report'),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            if (Get.isRegistered<FeatureWidgetInterface>(
                tag: 'ListVehicleWidget'))
              Get.find<FeatureWidgetInterface>(tag: 'ListVehicleWidget')
                  .buildView({
                "pageController": controller.pageController ,
                "currentPage": controller.currentPage,
                "haveAddVehicule": true,
                "title": "My Garage",
                "onSelected": (selectCar) {

                  print("Car Name: ${selectCar.name}, Car ID: ${selectCar.id}");
                },
                "onTapeAddVehicle": (){
                  print("clique");
                },
              }),
            Spacer(),
            Container(
              padding: EdgeInsets.all(10),
                child: Obx(() =>
                controller.currentPage.value == controller.cars.length?
                SizedBox() :
                    CustomButton(text: 'Generate repport', onPressed: (){
                      controller.goToOderDetails();
                    })
                )

            )

          ],
        ),
      )
    );
  }
}
