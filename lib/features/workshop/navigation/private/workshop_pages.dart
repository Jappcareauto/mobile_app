import 'package:get/get.dart';

import '../bindings/workshop_details_controller_binding.dart';
import '../../ui/workshopDetails/workshop_details_screen.dart';
import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/workshop/workshop_screen.dart';
import '../bindings/workshop_controller_binding.dart';
import 'workshop_private_routes.dart';

class WorkshopPages implements FeaturePages {
  @override
  List<GetPage>  getPages() => [
    GetPage(
      name: WorkshopPrivateRoutes.home,
      page: () => WorkshopScreen(),
      binding: WorkshopControllerBinding(),
    ),
    GetPage(
      name: WorkshopPrivateRoutes.workshopDetails,
      page: () => WorkshopDetailsScreen(),
      binding: WorkshopDetailsControllerBinding(),
    ),
    // Add other routes here
  ];
}
