import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/features/profile/navigation/private/profile_private_routes.dart';
import 'package:jappcare/features/shop/ui/orderSummary/controllers/order_summary_controller.dart';

class AddPaymentMethodController extends GetxController {
  late FormHelper formHelper;

  final AppNavigation _appNavigation;
  AddPaymentMethodController(this._appNavigation);

  @override
  onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void goToAddPaymentMethodForm(String? methode) {
    // Get.back();
    if (methode == PaymentMethod.card.value) {
      _appNavigation.toNamed(ProfilePrivateRoutes.addCardPaymentMethod);
    }
    if (methode == PaymentMethod.mtn.value ||
        methode == PaymentMethod.orange.value) {
      _appNavigation.toNamed(ProfilePrivateRoutes.addMomoPaymentMethod);
    }
  }
}
