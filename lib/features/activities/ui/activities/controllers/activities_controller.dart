import 'package:get/get.dart';
import 'package:jappcare/features/chat/navigation/private/chat_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class ActivitiesController extends GetxController {
  final AppNavigation _appNavigation;
  ActivitiesController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goToChatScreen() {
    _appNavigation.toNamed(ChatPrivateRoutes.home);
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
