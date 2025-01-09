import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/select_vehicule_slider_widget.dart';
import 'package:jappcare/features/garage/ui/generateVehicleReport/controllers/generate_vehicle_report_controller.dart';
import 'package:jappcare/features/services/ui/generateVehiculeReport/controllers/generate_vehicule_report_controller.dart';
import 'package:jappcare/features/services/ui/oderDetail/widgets/resume_services_widget.dart';
import 'controllers/oder_detail_controller.dart';
import 'package:get/get.dart';

class OderDetailScreen extends GetView<OderDetailController> {
  final GenerateVehiculeReportController generateVehicleReportController = Get.put(GenerateVehiculeReportController(Get.find()));
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppBar(title: 'Oder Details'),
      body: Container(
          child: Column(
            children: [
              SelectedVehiculeWidget(
                  pageController: generateVehicleReportController.pageController,
                  cars: generateVehicleReportController.vehicleList,
                  currentPage: generateVehicleReportController.currentPage,
                  haveAddVehicule: false,
                  titleText: 'Generate Report for'
              ),
              ResumeServicesWidget(),
              Spacer(),
              Container(
                padding: EdgeInsets.all(10),
                child: CustomButton(
                  text: 'Poceed',
                  onPressed: (){
                    controller.onpenModalPaymentMethod();
                  },
                ),
              )
            ],
          ),
        ),
      );
  }
}
