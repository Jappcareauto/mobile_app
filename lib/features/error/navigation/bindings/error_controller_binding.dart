import 'package:get/get.dart';
import '../../ui/error/controllers/error_controller.dart';

class ErrorControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ErrorController>(() => ErrorController(Get.find()));
  }
}
