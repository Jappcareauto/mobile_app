import 'package:get/get.dart';
import '../../ui/generateVehiculeReport/controllers/generate_vehicule_report_controller.dart';

class GenerateVehiculeReportControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateVehiculeReportController>(() => GenerateVehiculeReportController(Get.find()));
  }
}
