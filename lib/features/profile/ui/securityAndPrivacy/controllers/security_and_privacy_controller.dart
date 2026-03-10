import 'package:get/get.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../navigation/private/profile_private_routes.dart';

class SecurityAndPrivacyController extends GetxController {
  final AppNavigation _appNavigation;
  SecurityAndPrivacyController(this._appNavigation);

  void goBack() {
    _appNavigation.goBack();
  }

  void goToChangePassword() {
    _appNavigation.toNamed(ProfilePrivateRoutes.changePassword);
  }
}
