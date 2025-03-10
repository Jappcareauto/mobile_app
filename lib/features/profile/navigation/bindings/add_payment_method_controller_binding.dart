import 'package:get/get.dart';
import 'package:jappcare/features/profile/ui/payments/addPaymentMethod/controllers/add_payment_method_controller.dart';

class AddPaymentMethodControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPaymentMethodController>(
        () => AddPaymentMethodController(Get.find()));
  }
}
