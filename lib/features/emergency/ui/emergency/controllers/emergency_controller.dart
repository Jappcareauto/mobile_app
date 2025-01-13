import 'package:get/get.dart';
import 'package:jappcare/features/emergency/navigation/private/emergency_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class EmergencyController extends GetxController {
  final AppNavigation _appNavigation;
  EmergencyController(this._appNavigation);
  List<String> categorie = ['Tow my vehicle' , 'Break Failure' , 'Flat Tire' , 'Engine not starting' , 'Electrical Fault' , 'Other'] ;
  var selectedCategorie = ''.obs ;
  var selectedindex = 0.obs ;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }
  void goToEmergencyDetail(){
    _appNavigation.toNamed(EmergencyPrivateRoutes.emergencyDetail);
  }

  void goBack(){
    _appNavigation.goBack();
  }
}
