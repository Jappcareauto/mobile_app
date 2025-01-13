import 'package:get/get.dart';

import '../bindings/emergency_wait_response_controller_binding.dart';
import '../../ui/emergencyWaitResponse/emergency_wait_response_screen.dart';

import '../bindings/emergency_detail_controller_binding.dart';
import '../../ui/emergencyDetail/emergency_detail_screen.dart';
import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/emergency/emergency_screen.dart';
import '../bindings/emergency_controller_binding.dart';
import 'emergency_private_routes.dart';

class EmergencyPages implements FeaturePages {
  @override
  List<GetPage>  getPages() => [
    GetPage(
      name: EmergencyPrivateRoutes.home,
      page: () => EmergencyScreen(),
      binding: EmergencyControllerBinding(),
    ),
    GetPage(
      name: EmergencyPrivateRoutes.emergencyDetail,
      page: () => EmergencyDetailScreen(),
      binding: EmergencyDetailControllerBinding(),
    ),
    GetPage(
      name: EmergencyPrivateRoutes.emergencyWaitResponse,
      page: () => EmergencyWaitResponseScreen(),
      binding: EmergencyWaitResponseControllerBinding(),
    ),
    // Add other routes here
  ];
}
