import 'package:get/get.dart';
import '../../ui/authentification/controllers/authentification_controller.dart';

class AuthentificationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthentificationController>(() => AuthentificationController(Get.find()));
  }
}