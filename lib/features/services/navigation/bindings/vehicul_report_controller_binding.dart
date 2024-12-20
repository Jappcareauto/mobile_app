import 'package:get/get.dart';
import '../../ui/vehiculReport/controllers/vehicul_report_controller.dart';

class VehiculReportControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehiculReportController>(() => VehiculReportController(Get.find()));
  }
}
