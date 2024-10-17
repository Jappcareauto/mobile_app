import 'package:get/get.dart';
import '../../ui/loginWithPhone/controllers/login_with_phone_controller.dart';

class LoginWithPhoneControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginWithPhoneController>(() => LoginWithPhoneController(Get.find()));
  }
}
