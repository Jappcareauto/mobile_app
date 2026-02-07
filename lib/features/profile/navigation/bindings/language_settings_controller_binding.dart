import 'package:get/get.dart';
import '../../ui/language/controllers/language_settings_controller.dart';

class LanguageSettingsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageSettingsController>(
      () => LanguageSettingsController(Get.find()),
    );
  }
}
