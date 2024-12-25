import 'package:get/get.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class EmergencyWaitResponseController extends GetxController {
  final AppNavigation _appNavigation;
  EmergencyWaitResponseController(this._appNavigation);
  var isExpanded = true.obs ;
  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack(){
    _appNavigation.goBack();
  }
  void processChat(){
    _appNavigation.toNamed(AppRoutes.workshopchat);
  }
}
