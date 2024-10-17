import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';

class AddVehicleController extends GetxController {
  final AppNavigation _appNavigation;
  AddVehicleController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack(){
    _appNavigation.goBack();
  }
}
