import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';

class DashboardController extends GetxController {
  final AppNavigation _appNavigation;
  DashboardController(this._appNavigation);

  final selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
    update();
  }


  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack(){
    _appNavigation.goBack();
  }
}
