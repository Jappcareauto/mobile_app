import 'package:get/get.dart';
import '../../ui/onboarding/controllers/onboarding_controller.dart';

class OnboardingControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController(Get.find()));
  }
}
