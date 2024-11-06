import 'package:get/get.dart';
import '../../ui/termsAndConditions/controllers/terms_and_conditions_controller.dart';

class TermsAndConditionsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsAndConditionsController>(() => TermsAndConditionsController(Get.find()));
  }
}
