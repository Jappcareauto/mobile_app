import 'package:get/get.dart';
import '../../ui/editProfile/controllers/edit_profile_controller.dart';

class EditProfileControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController(Get.find()));
  }
}
