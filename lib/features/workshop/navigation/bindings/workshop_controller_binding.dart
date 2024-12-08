import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/controllers/services_locator_controller.dart';
import '../../ui/workshop/controllers/workshop_controller.dart';

class WorkshopControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkshopController>(() => WorkshopController(Get.find()));

  }
}
