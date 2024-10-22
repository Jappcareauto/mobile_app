import 'package:get/get.dart';
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
    // Add other routes here
  ];
}
