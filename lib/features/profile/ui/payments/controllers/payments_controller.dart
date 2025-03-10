import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/profile/navigation/private/profile_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class PaymentsController extends GetxController {
  final AppNavigation _appNavigation;
  final selectedMethod = ''.obs;
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
      selectedMethod.value = AppImages.cardPayment;
    } else {
      selectedMethod.value = AppImages.momo;
    }
  }

  void goToAddPaymentMethods() {
    if (selectedMethod.value == AppImages.cardPayment) {
      Get.back();
      _appNavigation.toNamed(ProfilePrivateRoutes.addCardPaymentMethod);
    }
    if (selectedMethod.value == AppImages.momo
        // ||
        // selectedMethod.value == 'Orange Money'
        ) {
      Get.back();
      _appNavigation.toNamed(ProfilePrivateRoutes.addMomoPaymentMethod);
    }
  }
}
