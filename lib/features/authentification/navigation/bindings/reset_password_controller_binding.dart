import 'package:get/get.dart';
import '../../ui/resetPassword/controllers/reset_password_controller.dart';

class ResetPasswordControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController(Get.find()));
  }
}
