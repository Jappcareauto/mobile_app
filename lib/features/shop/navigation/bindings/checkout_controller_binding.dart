import 'package:get/get.dart';
import '../../ui/checkout/controllers/checkout_controller.dart';

class CheckoutControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(() => CheckoutController(Get.find()));
  }
}
