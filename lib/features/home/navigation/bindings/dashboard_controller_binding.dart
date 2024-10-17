import 'package:get/get.dart';
import '../../ui/dashboard/controllers/dashboard_controller.dart';

class DashboardControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController(Get.find()));
  }
}
