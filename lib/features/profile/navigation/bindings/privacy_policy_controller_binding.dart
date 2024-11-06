import 'package:get/get.dart';
import '../../ui/privacyPolicy/controllers/privacy_policy_controller.dart';

class PrivacyPolicyControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyPolicyController>(() => PrivacyPolicyController(Get.find()));
  }
}
