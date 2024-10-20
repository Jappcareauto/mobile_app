import 'package:get/get.dart';
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
    // Add other routes here
  ];
}
