import 'package:get/get.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import 'package:jappcare/features/home/ui/home/home_screen.dart';
import '../../../../../core/navigation/app_navigation.dart';

class CommingSoonController extends GetxController {
  final AppNavigation _appNavigation;
  CommingSoonController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack(){
    _appNavigation.goBack();
  }


}
