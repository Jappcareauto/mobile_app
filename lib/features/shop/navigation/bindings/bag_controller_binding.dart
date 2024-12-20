import 'package:get/get.dart';
import '../../ui/bag/controllers/bag_controller.dart';

class BagControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BagController>(() => BagController(Get.find()));
  }
}
