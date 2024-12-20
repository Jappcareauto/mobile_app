import 'package:get/get.dart';
import '../../ui/confirmTransaction/controllers/confirm_transaction_controller.dart';

class ConfirmTransactionControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmTransactionController>(() => ConfirmTransactionController(Get.find()));
  }
}
