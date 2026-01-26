import 'package:get/get.dart';
import 'package:jappcare/features/garage/domain/repositories/garage_repository.dart';
import 'package:jappcare/features/workshop/application/usecases/make_cash_payment_usecase.dart';
import '../../ui/invoice/controllers/invoice_controller.dart';

class InvoiceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceController>(() => InvoiceController(
          Get.find(),
          Get.find<GarageRepository>(),
          Get.find<MakeCashPaymentUseCase>(),
        ));
  }
}
