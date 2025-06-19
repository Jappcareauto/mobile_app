import 'package:get/get.dart';
import '../../ui/ordersummary2/controllers/ordersummary2_controller.dart';

class Ordersummary2ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Ordersummary2Controller>(
        () => Ordersummary2Controller(Get.find()));
  }
}
