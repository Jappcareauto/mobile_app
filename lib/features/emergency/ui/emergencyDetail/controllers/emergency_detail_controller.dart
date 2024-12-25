import 'package:get/get.dart';
import 'package:jappcare/features/emergency/navigation/private/emergency_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class EmergencyDetailController extends GetxController {
  final AppNavigation _appNavigation;
  EmergencyDetailController(this._appNavigation);
  var savePhoneNumberPaymentMethod = false.obs ;
  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack(){
    _appNavigation.goBack();
  }
  void goToWaitResponse(){
    _appNavigation.toNamed(EmergencyPrivateRoutes.emergencyWaitResponse);
  }
}
