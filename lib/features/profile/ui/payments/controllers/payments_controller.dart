import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_images.dart';
import '../../../../../core/navigation/app_navigation.dart';

class PaymentsController extends GetxController {
  final AppNavigation _appNavigation;
  PaymentsController(this._appNavigation);

  final payments = [AppImages.cardPayment, AppImages.momo];

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void onPaymentMethodsSelected(String paymentMethod) {
    if (paymentMethod == AppImages.cardPayment) {
      goToAddPaymentMethods();
    }
  }

  void goToAddPaymentMethods() {}
}
