import 'package:get/get.dart';
import '../../ui/checkoutCardDetails/controllers/checkout_card_details_controller.dart';

class CheckoutCardDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutCardDetailsController>(() => CheckoutCardDetailsController(Get.find()));
  }
}
