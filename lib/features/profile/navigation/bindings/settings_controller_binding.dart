import 'package:get/get.dart';
import '../../ui/settings/controllers/settings_controller.dart';

class SettingsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController(Get.find()));
  }
}
