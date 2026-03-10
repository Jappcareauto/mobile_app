import 'package:get/get.dart';
import '../../ui/securityAndPrivacy/controllers/security_and_privacy_controller.dart';

class SecurityAndPrivacyControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecurityAndPrivacyController>(
      () => SecurityAndPrivacyController(Get.find()),
    );
  }
}
