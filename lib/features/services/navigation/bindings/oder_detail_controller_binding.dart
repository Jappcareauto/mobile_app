import 'package:get/get.dart';
import '../../ui/oderDetail/controllers/oder_detail_controller.dart';

class OderDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OderDetailController>(() => OderDetailController(Get.find()));
  }
}
