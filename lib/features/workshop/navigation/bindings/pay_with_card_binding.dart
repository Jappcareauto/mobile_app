import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/PayWithCard/controllers/pay_with_card_controller.dart';

class PayWithCardBindings extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<PayWithCardController>(() => PayWithCardController(Get.find()));
  }
}