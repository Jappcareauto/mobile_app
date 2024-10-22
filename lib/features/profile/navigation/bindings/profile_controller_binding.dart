import 'package:get/get.dart';
import '../../ui/profile/controllers/profile_controller.dart';

class ProfileControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController(Get.find()));
  }
}
