import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/controllers/services_locator_controller.dart';


class ServicesLocatorBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<ServicesLocatorController>(() => ServicesLocatorController(Get.find()));

  }
}
