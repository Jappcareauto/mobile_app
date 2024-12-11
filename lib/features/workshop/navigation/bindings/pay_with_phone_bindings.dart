import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/PayWithPhone/controller/pay_with_phone_controller.dart';

class PayWithPhoneBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<PayWithPhoneController>(() => PayWithPhoneController(Get.find()));
  }

}