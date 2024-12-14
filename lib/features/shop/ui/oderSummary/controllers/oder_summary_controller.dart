import 'package:get/get.dart';
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
}
