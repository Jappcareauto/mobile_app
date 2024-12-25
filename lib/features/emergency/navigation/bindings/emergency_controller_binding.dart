import 'package:get/get.dart';
import '../../ui/emergency/controllers/emergency_controller.dart';

class EmergencyControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmergencyController>(() => EmergencyController(Get.find()));
  }
}
