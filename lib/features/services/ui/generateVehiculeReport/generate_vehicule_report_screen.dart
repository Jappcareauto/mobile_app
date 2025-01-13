import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/select_vehicule_slider_widget.dart';
import 'controllers/generate_vehicule_report_controller.dart';
import 'package:get/get.dart';

class GenerateVehiculeReportScreen extends GetView<GenerateVehiculeReportController> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(title: 'Generate \n Vehicule Report'),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SelectedVehiculeWidget(
              onTapeAddVehicle: (){
                controller.goToAddVehicle();
              },
                haveAddVehicule: true,
                pageController: controller.pageController,
                cars: controller.garageController.vehicleList,
                currentPage: controller.currentPage,
                titleText: 'Selected Vehicle',

            ),
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
