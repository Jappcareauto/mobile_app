import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../navigation/private/garage_private_routes.dart';

class GarageController extends GetxController {
  final AppNavigation _appNavigation;
  GarageController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }


  void goBack(){
    _appNavigation.goBack();
  }

  void goToAddVehicle(){
    _appNavigation.toNamed(GaragePrivateRoutes.addVehicle);
  }

  void goToVehicleDetails() {
    _appNavigation.toNamed(GaragePrivateRoutes.vehicleDetails);
  }
}
