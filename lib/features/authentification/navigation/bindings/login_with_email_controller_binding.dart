import 'package:get/get.dart';
import '../../ui/loginWithEmail/controllers/login_with_email_controller.dart';

class LoginWithEmailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginWithEmailController>(() => LoginWithEmailController(Get.find()));
  }
}
