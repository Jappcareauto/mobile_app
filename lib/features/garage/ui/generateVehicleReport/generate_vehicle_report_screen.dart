import 'package:flutter/material.dart';
import 'package:jappcare/core/ui/widgets/custom_app_bar.dart';
import 'package:jappcare/core/ui/widgets/custom_button.dart';
import '../garage/widgets/list_veehicle_widget.dart';
import 'controllers/generate_vehicle_report_controller.dart';
import 'package:get/get.dart';

class GenerateVehicleReportScreen
    extends GetView<GenerateVehicleReportController> {
  const GenerateVehicleReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Generate\nVehicle Report"),
      body: Obx(() => Column(
            children: [
              const SizedBox(height: 20),
              ListVehicleWidget(
                title: "Select Vehicle",
                selectedIndex: controller.selectedIndex.value,
                onSelected: controller.onChangeIndex,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  text: "Generate Report",
                  onPressed: controller.onGenerateReportPress,
                  isLoading: controller.loading,
                ),
              ),
              const SizedBox(height: 20),
            ],
          )),
    );
  }
}
