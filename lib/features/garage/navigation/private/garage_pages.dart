import 'package:get/get.dart';
import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/garage/garage_screen.dart';
import '../bindings/garage_controller_binding.dart';
import 'garage_private_routes.dart';

class GaragePages implements FeaturePages {
  @override
  List<GetPage>  getPages() => [
    GetPage(
      name: GaragePrivateRoutes.home,
      page: () => GarageScreen(),
      binding: GarageControllerBinding(),
    ),
    // Add other routes here
  ];
}
