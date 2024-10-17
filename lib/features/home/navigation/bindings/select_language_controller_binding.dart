import 'package:get/get.dart';
import '../../ui/selectLanguage/controllers/select_language_controller.dart';

class SelectLanguageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectLanguageController>(() => SelectLanguageController(Get.find()));
  }
}
