import 'package:get/get.dart';

import '../bindings/oder_summary_controller_binding.dart';
import '../../ui/oderSummary/oder_summary_screen.dart';

import '../bindings/checkout_controller_binding.dart';
import '../../ui/checkout/checkout_screen.dart';

import '../bindings/bag_controller_binding.dart';
import '../../ui/bag/bag_screen.dart';

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
    GetPage(
      name: ShopPrivateRoutes.bag,
      page: () => BagScreen(),
      binding: BagControllerBinding(),
    ),
    GetPage(
      name: ShopPrivateRoutes.checkout,
      page: () => CheckoutScreen(),
      binding: CheckoutControllerBinding(),
    ),
    GetPage(
      name: ShopPrivateRoutes.oderSummary,
      page: () => OderSummaryScreen(),
      binding: OderSummaryControllerBinding(),
    ),
    // Add other routes here
  ];
}
