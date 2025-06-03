import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/interfaces/feature_widget_interface.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'controllers/generate_vehicule_report_controller.dart';
import 'package:get/get.dart';

class GenerateVehiculeReportScreen
    extends GetView<GenerateVehiculeReportController> {
  final GarageController garageController =
      GarageController(Get.find(), Get.find());

  GenerateVehiculeReportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Generate \n Vehicule Report'),
        body: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              if (Get.isRegistered<FeatureWidgetInterface>(
                  tag: 'ListVehicleWidget'))
                Get.find<FeatureWidgetInterface>(tag: 'ListVehicleWidget')
                    .buildView({
                  "pageController": controller.pageController,
                  "currentPage": controller.currentPage,
                  "haveAddVehicule": true,
                  "title": "My Garage",
                  "onSelected": (selectCar) {
                    print(
                        "Car Name: ${selectCar.name}, Car ID: ${selectCar.id}");
                  },
                  "onTapeAddVehicle": () {
                    print("clique");
                  },
                }),
              const Spacer(),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Obx(() =>
                      controller.currentPage.value == controller.cars.length
                          ? const SizedBox()
                          : CustomButton(
                              text: 'Generate repport',
                              onPressed: () {
                                controller.goToOderDetails();
                              })))
            ],
          ),
        ));
  }
}
