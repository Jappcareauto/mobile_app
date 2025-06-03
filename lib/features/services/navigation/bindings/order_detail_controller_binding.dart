import 'package:get/get.dart';
import '../../ui/oderDetail/controllers/order_detail_controller.dart';

class OrderDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailController>(() => OrderDetailController(Get.find()));
  }
}
