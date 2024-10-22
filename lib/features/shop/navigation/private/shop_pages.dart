import 'package:get/get.dart';
import '../../../../core/navigation/routes/features_pages.dart';
import '../../ui/shop/shop_screen.dart';
import '../bindings/shop_controller_binding.dart';
import 'shop_private_routes.dart';

class ShopPages implements FeaturePages {
  @override
  List<GetPage>  getPages() => [
    GetPage(
      name: ShopPrivateRoutes.home,
      page: () => ShopScreen(),
      binding: ShopControllerBinding(),
    ),
    // Add other routes here
  ];
}
