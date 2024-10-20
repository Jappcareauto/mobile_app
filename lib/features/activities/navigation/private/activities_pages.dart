import 'package:get/get.dart';
import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/activities/activities_screen.dart';
import '../bindings/activities_controller_binding.dart';
import 'activities_private_routes.dart';

class ActivitiesPages implements FeaturePages {
  @override
  List<GetPage>  getPages() => [
    GetPage(
      name: ActivitiesPrivateRoutes.home,
      page: () => ActivitiesScreen(),
      binding: ActivitiesControllerBinding(),
    ),
    // Add other routes here
  ];
}
