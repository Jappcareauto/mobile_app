import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_images.dart';
import '../../../../../core/navigation/app_navigation.dart';

class ShopController extends GetxController {
  final AppNavigation _appNavigation;
  ShopController(this._appNavigation);

  final List<Map<String, dynamic>> parts = [
    {
      'imagePath': AppImages.shop1,
      'name': 'Porsche 911 Matrix LED Headlights',
      'price': '5,000 Frs',
    },
    {
      'imagePath': AppImages.shop2,
      'name': 'BMW M5 Turbocharged V8 Engine',
      'price': '6,000 Frs',
    },
    {
      'imagePath': AppImages.shop3,
      'name': 'Lamborghini Urus V10 Front Bumper',
      'price': '7,000 Frs',
    },
    {
      'imagePath': AppImages.shop1,
      'name': 'Porsche Macan Headlights',
      'price': '102,000 Frs',
    },
    {
      'imagePath': AppImages.shop3,
      'name': 'Lamborghini Urus V10 Front Bumper',
      'price': '7,000 Frs',
    },
    {
      'imagePath': AppImages.shop1,
      'name': 'Porsche Macan Headlights',
      'price': '102,000 Frs',
    },
  ];

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
