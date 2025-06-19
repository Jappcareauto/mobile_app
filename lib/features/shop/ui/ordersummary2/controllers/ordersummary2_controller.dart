import 'package:get/get.dart';
import 'package:jappcare/features/shop/navigation/private/shop_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class Ordersummary2Controller extends GetxController {
  final AppNavigation _appNavigation;
  Ordersummary2Controller(this._appNavigation);
  var items = [
    {"name": "Vehicle Report", "quantity": "1x", "price": 5000},
    {"name": "Lamborghini Urus Headlight", "quantity": "2x", "price": 250000},
    {
      "name": "Michelin Pilot Sport 4S Tires",
      "quantity": "4x",
      "price": 400000
    },
    {"name": "Carbon Fiber Spoiler", "quantity": "1x", "price": 150000},
    {"name": "Brembo Brake Kit", "quantity": "1x", "price": 300000},
    {"name": "Akrapovic Exhaust System", "quantity": "1x", "price": 500000},
    {"name": "Custom Paint Job", "quantity": "1x", "price": 200000},
  ].obs;

  // Calcul du total
  int get totalPrice =>
      items.fold(0, (sum, item) => sum + (item['price'] as int));

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void goToPayWithPhone() {
    _appNavigation.toNamed(ShopPrivateRoutes.checkoutPhoneDetail);
  }
}
