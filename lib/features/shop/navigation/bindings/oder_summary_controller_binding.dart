import 'package:get/get.dart';
import '../../ui/orderSummary/controllers/order_summary_controller.dart';

class OrderSummaryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderSummaryController>(
        () => OrderSummaryController(Get.find()));
  }
}
