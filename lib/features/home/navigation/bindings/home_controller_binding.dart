import 'package:get/get.dart';
import '../../ui/home/controllers/home_controller.dart';
import '../../ui/dashboard/controllers/dashboard_controller.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
    // DashboardController is needed by HomeScreen for navigation
    if (!Get.isRegistered<DashboardController>()) {
      Get.lazyPut<DashboardController>(() => DashboardController(Get.find()));
    }
  }
}
