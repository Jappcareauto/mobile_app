import 'package:get/get.dart';

import '../bindings/vehicle_details_controller_binding.dart';
import '../../ui/vehicleDetails/vehicle_details_screen.dart';

import '../bindings/add_vehicle_controller_binding.dart';
import '../../ui/addVehicle/add_vehicle_screen.dart';
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
    GetPage(
      name: GaragePrivateRoutes.addVehicle,
      page: () => AddVehicleScreen(),
      binding: AddVehicleControllerBinding(),
    ),
    GetPage(
      name: GaragePrivateRoutes.vehicleDetails,
      page: () => VehicleDetailsScreen(),
      binding: VehicleDetailsControllerBinding(),
    ),
    // Add other routes here
  ];
}
