import 'package:get/get.dart';
import 'package:jappcare/features/profile/navigation/private/profile_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class ProfileController extends GetxController {
  final AppNavigation _appNavigation;
  ProfileController(this._appNavigation);

  final imageUrl = "https://i.pravatar.cc/300".obs;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void goToProfile() {
    _appNavigation.toNamed(ProfilePrivateRoutes.home);
  }
}
