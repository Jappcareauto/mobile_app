import 'package:get/get.dart';
import '../../ui/recepit/controllers/recepit_controller.dart';

class RecepitControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecepitController>(() => RecepitController(Get.find()));
  }
}
