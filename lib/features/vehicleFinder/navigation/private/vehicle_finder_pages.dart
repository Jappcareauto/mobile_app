import 'package:get/get.dart';
import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/vehicleFinder/vehicle_finder_screen.dart';
import '../bindings/vehicle_finder_controller_binding.dart';
import 'vehicle_finder_private_routes.dart';

class VehicleFinderPages implements FeaturePages {
  @override
  List<GetPage>  getPages() => [
    GetPage(
      name: VehicleFinderPrivateRoutes.home,
      page: () => VehicleFinderScreen(),
      binding: VehicleFinderControllerBinding(),
    ),
    // Add other routes here
  ];
}
