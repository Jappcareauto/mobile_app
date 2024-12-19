import 'package:get/get.dart';
import '../../ui/services/controllers/services_controller.dart';

class ServicesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesController>(() => ServicesController(Get.find()));
  }
}
