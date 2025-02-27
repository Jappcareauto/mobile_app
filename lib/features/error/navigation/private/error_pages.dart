import 'package:get/get.dart';

import '../bindings/network_error_controller_binding.dart';
import '../../ui/networkError/network_error_screen.dart';

import '../bindings/comming_soon_controller_binding.dart';
import '../../ui/commingSoon/comming_soon_screen.dart';
import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/error/error_screen.dart';
import '../bindings/error_controller_binding.dart';
import 'error_private_routes.dart';

class ErrorPages implements FeaturePages {
  @override
  List<GetPage>  getPages() => [
    GetPage(
      name: ErrorPrivateRoutes.home,
      page: () => const ErrorScreen(),
      binding: ErrorControllerBinding(),
    ),
    GetPage(
      name: ErrorPrivateRoutes.commingSoon,
      page: () => const CommingSoonScreen(),
      binding: CommingSoonControllerBinding(),
    ),
    GetPage(
      name: ErrorPrivateRoutes.networkError,
      page: () => const NetworkErrorScreen(),
      binding: NetworkErrorControllerBinding(),
    ),
    // Add other routes here
  ];
}
