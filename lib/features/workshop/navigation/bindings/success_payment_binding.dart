import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/sucess_payment/controller/success_payment_controller.dart';

class SuccessPaymentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SuccessPaymentController>(() => SuccessPaymentController(Get.find()));
  }

}