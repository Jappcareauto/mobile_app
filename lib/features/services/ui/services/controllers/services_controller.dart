import 'package:get/get.dart';
import 'package:jappcare/features/services/navigation/private/services_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class ServicesController extends GetxController {
  final AppNavigation _appNavigation;
  ServicesController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack(){
    _appNavigation.goBack();
  }
  void goToGenerateVehiculeReport(){
    _appNavigation.toNamed(ServicesPrivateRoutes.generateVehiculeReport);
  }
}
