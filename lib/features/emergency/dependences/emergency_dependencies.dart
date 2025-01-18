import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/controllers/services_locator_controller.dart';
class EmergencyDependencies {
  static void init() {

    Get.lazyPut<ServicesLocatorController>(() => ServicesLocatorController(Get.find())  , fenix: true);

}
}


