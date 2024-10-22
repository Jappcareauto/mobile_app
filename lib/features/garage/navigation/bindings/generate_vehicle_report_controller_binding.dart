import 'package:get/get.dart';
import '../../ui/generateVehicleReport/controllers/generate_vehicle_report_controller.dart';

class GenerateVehicleReportControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateVehicleReportController>(() => GenerateVehicleReportController(Get.find()));
  }
}
