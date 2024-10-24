import 'package:get/get.dart';

import '../bindings/settings_controller_binding.dart';
import '../../ui/settings/settings_screen.dart';
import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/profile/profile_screen.dart';
import '../bindings/profile_controller_binding.dart';
import 'profile_private_routes.dart';

class ProfilePages implements FeaturePages {
  @override
  List<GetPage>  getPages() => [
    GetPage(
      name: ProfilePrivateRoutes.home,
      page: () => ProfileScreen(),
      binding: ProfileControllerBinding(),
    ),
    GetPage(
      name: ProfilePrivateRoutes.settings,
      page: () => SettingsScreen(),
      binding: SettingsControllerBinding(),
    ),
    // Add other routes here
  ];
}
