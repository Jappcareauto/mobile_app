import 'package:get/get.dart';
import 'package:jappcare/features/shop/navigation/private/shop_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class ProductDetailsController extends GetxController {
  final AppNavigation _appNavigation;
  ProductDetailsController(this._appNavigation);
  var quantity = 0.obs ;
  var totalPrice = 0.obs;
  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack(){
    _appNavigation.goBack();
  }
  void addQuantity(int price){
    quantity.value++;
    totalPrice.value = quantity.value*price ;
  }
  void removeQuantity(int price){
    quantity.value--;
    totalPrice.value = quantity.value*price ;
  }
  void goToBag () {
    _appNavigation.toNamed(ShopPrivateRoutes.bag);
  }
}
