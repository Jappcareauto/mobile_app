import 'package:get/get.dart';
import '../../ui/workshop/controllers/workshop_controller.dart';

class WorkshopControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkshopController>(() => WorkshopController(Get.find()));
  }
}
