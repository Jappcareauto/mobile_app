import 'package:get/get.dart';
import '../../ui/payments/controllers/payments_controller.dart';

class PaymentsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentsController>(() => PaymentsController(Get.find()));
  }
}
