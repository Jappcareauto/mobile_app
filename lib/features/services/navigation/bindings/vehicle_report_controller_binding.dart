import 'package:get/get.dart';
import '../../ui/vehicleReport/controllers/vehicle_report_controller.dart';

class VehicleReportControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleReportController>(
        () => VehicleReportController(Get.find()));
  }
}
