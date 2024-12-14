import 'package:get/get.dart';
import '../../ui/invoice/controllers/invoice_controller.dart';

class InvoiceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceController>(() => InvoiceController(Get.find()));
  }
}
