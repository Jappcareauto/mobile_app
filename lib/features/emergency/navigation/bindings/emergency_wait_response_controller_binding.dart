import 'package:get/get.dart';
import '../../ui/emergencyWaitResponse/controllers/emergency_wait_response_controller.dart';

class EmergencyWaitResponseControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmergencyWaitResponseController>(() => EmergencyWaitResponseController(Get.find()));
  }
}
