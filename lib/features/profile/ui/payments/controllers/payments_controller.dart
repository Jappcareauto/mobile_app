import 'dart:ui';

import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/profile/domain/entities/credit_card.dart';
import 'package:jappcare/features/profile/navigation/private/profile_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class PaymentsController extends GetxController {
  final AppNavigation _appNavigation;
  final selectedMethod = ''.obs;
  PaymentsController(this._appNavigation);

  final paymentsMethods = [
    AppImages.cardPayment,
    AppImages.momo,
    // AppImages.orangeLogo
  ];

  final List<CreditCard> creditCards = [
    CreditCard(
      cardNumber: '**** **** **** 1234',
      cardHolder: 'JOHN SMITH',
      expiryDate: '12/25',
      cardType: 'VISA',
      cardColor: const Color(0xFF1E3A8A),
    ),
    CreditCard(
      cardNumber: '**** **** **** 5678',
      cardHolder: 'SARAH JOHNSON',
      expiryDate: '08/26',
      cardType: 'MASTERCARD',
      cardColor: const Color(0xFFDC2626),
    ),
    CreditCard(
      cardNumber: '**** **** **** 9012',
      cardHolder: 'MICHAEL DAVIS',
      expiryDate: '03/27',
      cardType: 'AMEX',
      cardColor: const Color(0xFF059669),
    ),
    CreditCard(
      cardNumber: '**** **** **** 3456',
      cardHolder: 'EMMA WILSON',
      expiryDate: '11/24',
      cardType: 'VISA',
      cardColor: const Color(0xFF7C3AED),
    ),
    CreditCard(
      cardNumber: '**** **** **** 7890',
      cardHolder: 'DAVID BROWN',
      expiryDate: '06/28',
      cardType: 'MASTERCARD',
      cardColor: const Color(0xFFEA580C),
    ),
  ];

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
