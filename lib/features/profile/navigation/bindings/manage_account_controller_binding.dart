import 'package:get/get.dart';
import '../../ui/manageAccount/controllers/manage_account_controller.dart';

class ManageAccountControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageAccountController>(
      () => ManageAccountController(),
    );
  }
}
