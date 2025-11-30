import 'package:get/get.dart';
import 'package:jappcare/core/utils/enums.dart';
import 'package:jappcare/features/shop/navigation/private/shop_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class OrderSummaryController extends GetxController {
  final AppNavigation _appNavigation;
  OrderSummaryController(this._appNavigation);
  final RxString selectedMethod = PaymentMethod.orange.value.obs;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void selectPaymentMethod(String methode) {
    selectedMethod.value = methode;
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void goToOrderSummary2() {
    _appNavigation.toNamed(ShopPrivateRoutes.odersummary2);
  }
}
