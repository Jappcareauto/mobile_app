import 'package:get/get.dart';
import '../../ui/verifyYourEmail/controllers/verify_your_email_controller.dart';

class VerifyYourEmailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyYourEmailController>(() => VerifyYourEmailController(Get.find()));
  }
}
