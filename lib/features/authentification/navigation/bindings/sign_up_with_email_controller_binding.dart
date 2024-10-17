import 'package:get/get.dart';
import '../../ui/signUpWithEmail/controllers/sign_up_with_email_controller.dart';

class SignUpWithEmailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpWithEmailController>(() => SignUpWithEmailController(Get.find()));
  }
}
