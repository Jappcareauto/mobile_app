import 'package:get/get.dart';
import '../../ui/checkoutPhoneDetail/controllers/checkout_phone_detail_controller.dart';

class CheckoutPhoneDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutPhoneDetailController>(() => CheckoutPhoneDetailController(Get.find()));
  }
}
