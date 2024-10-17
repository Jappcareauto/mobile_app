import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';

class VehicleDetailsController extends GetxController {
  final AppNavigation _appNavigation;
  VehicleDetailsController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack(){
    _appNavigation.goBack();
  }
}
