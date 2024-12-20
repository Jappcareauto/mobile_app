import 'package:get/get.dart';
import 'package:jappcare/features/shop/navigation/private/shop_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class CheckoutPhoneDetailController extends GetxController {
  final AppNavigation _appNavigation;
  CheckoutPhoneDetailController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack(){
    _appNavigation.goBack();
  }
  void goToPayWithCard(){
    _appNavigation.toNamed(ShopPrivateRoutes.checkoutCardDetails);
  }
}
