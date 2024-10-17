import 'package:get/get.dart';
import '../../ui/garage/controllers/garage_controller.dart';

class GarageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GarageController>(() => GarageController(Get.find()));
  }
}
