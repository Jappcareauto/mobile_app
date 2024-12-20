import 'package:get/get.dart';
import 'package:jappcare/features/shop/navigation/private/shop_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class OderSummaryController extends GetxController {
  final AppNavigation _appNavigation;
  OderSummaryController(this._appNavigation);
  final selectedMethod = 'ORANGE'.obs ;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }
  void selectMethode (String methode){
    selectedMethod.value = methode ;
  }
  void goBack(){
    _appNavigation.goBack();
  }
  void goToOderSummary2(){
    _appNavigation.toNamed(ShopPrivateRoutes.odersummary2);
  }
}
