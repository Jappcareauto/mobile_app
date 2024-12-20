import 'package:get/get.dart';
import 'package:jappcare/features/shop/navigation/private/shop_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class BagController extends GetxController {
  final AppNavigation _appNavigation;
  var quantity = 1.obs;
  var totalPrice = 125000.obs;

  BagController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack(){
    _appNavigation.goBack();
  }

  void incrementQuantity() {
    quantity.value++;
    updateTotalPrice();
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
      updateTotalPrice();
    }
  }
  void goToCheckout(){
    _appNavigation.toNamed(ShopPrivateRoutes.checkout);
  }
  void updateTotalPrice() {
    totalPrice.value = quantity.value * 125000; // Prix unitaire
  }
}
