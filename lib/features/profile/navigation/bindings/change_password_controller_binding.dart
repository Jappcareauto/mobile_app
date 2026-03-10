import 'package:get/get.dart';
import '../../ui/changePassword/controllers/change_password_controller.dart';

class ChangePasswordControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(Get.find()),
    );
  }
}
