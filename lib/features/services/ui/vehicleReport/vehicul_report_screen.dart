import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import 'package:jappcare/core/ui/widgets/image_component.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/services/ui/vehicleReport/widgets/card_details_widget.dart';
import 'package:jappcare/features/shop/ui/shop/widgets/tabs_list_widgets.dart';
import 'controllers/vehicle_report_controller.dart';
import 'package:get/get.dart';

class VehicleReportScreen extends GetView<VehicleReportController> {
  const VehicleReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Vehicle Report'),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Porsche Taycan Turbo S',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    color: Color(0xFFFB7C37)),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '2024, RWD',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  text: 'Download Report',
                  strech: false,
                  width: 200,
                  borderRadius: BorderRadius.circular(30),
                  haveBorder: true,
                  onPressed: () {}),
              const ImageComponent(
                assetPath: AppImages.carWhite,
              ),
              TabsListWidgets(
                  tabs: controller.texts,
                  selectedFilter: controller.selectedFilter,
                  selectedTabs: controller.selectedTabs,
                  borderRadius: BorderRadius.circular(30),
                  haveBorder: false),
              const SizedBox(
                height: 20,
              ),
              const CardDetailsWidget()
            ],
          ),
        )));
  }
}
