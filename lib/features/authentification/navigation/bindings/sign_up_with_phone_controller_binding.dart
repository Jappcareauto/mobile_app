import 'package:get/get.dart';
import '../../ui/signUpWithPhone/controllers/sign_up_with_phone_controller.dart';

class SignUpWithPhoneControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpWithPhoneController>(() => SignUpWithPhoneController(Get.find()));
  }
}
