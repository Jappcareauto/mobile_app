import 'package:get/get.dart';
import '../../ui/emergencyDetail/controllers/emergency_detail_controller.dart';

class EmergencyDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmergencyDetailController>(() => EmergencyDetailController(Get.find()));
  }
}
