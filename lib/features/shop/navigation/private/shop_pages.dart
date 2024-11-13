import 'package:get/get.dart';

import '../bindings/product_details_controller_binding.dart';
import '../../ui/productDetails/product_details_screen.dart';
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
    GetPage(
      name: ShopPrivateRoutes.productDetails,
      page: () => ProductDetailsScreen(),
      binding: ProductDetailsControllerBinding(),
    ),
    // Add other routes here
  ];
}
