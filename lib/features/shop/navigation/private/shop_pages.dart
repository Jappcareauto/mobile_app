import 'package:get/get.dart';

import '../bindings/recepit_controller_binding.dart';
import '../../ui/recepit/recepit_screen.dart';

import '../bindings/confirm_transaction_controller_binding.dart';
import '../../ui/confirmTransaction/confirm_transaction_screen.dart';

import '../bindings/checkout_card_details_controller_binding.dart';
import '../../ui/checkoutCardDetails/checkout_card_details_screen.dart';

import '../bindings/checkout_phone_detail_controller_binding.dart';
import '../../ui/checkoutPhoneDetail/checkout_phone_detail_screen.dart';

import '../bindings/odersummary2_controller_binding.dart';
import '../../ui/odersummary2/odersummary2_screen.dart';

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
    GetPage(
      name: ShopPrivateRoutes.odersummary2,
      page: () => Odersummary2Screen(),
      binding: Odersummary2ControllerBinding(),
    ),
    GetPage(
      name: ShopPrivateRoutes.checkoutPhoneDetail,
      page: () => CheckoutPhoneDetailScreen(),
      binding: CheckoutPhoneDetailControllerBinding(),
    ),
    GetPage(
      name: ShopPrivateRoutes.checkoutCardDetails,
      page: () => CheckoutCardDetailsScreen(),
      binding: CheckoutCardDetailsControllerBinding(),
    ),
    GetPage(
      name: ShopPrivateRoutes.confirmTransaction,
      page: () => ConfirmTransactionScreen(),
      binding: ConfirmTransactionControllerBinding(),
    ),
    GetPage(
      name: ShopPrivateRoutes.recepit,
      page: () => RecepitScreen(),
      binding: RecepitControllerBinding(),
    ),
    // Add other routes here
  ];
}
