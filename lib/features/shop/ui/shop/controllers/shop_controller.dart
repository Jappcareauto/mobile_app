import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/shop/navigation/private/shop_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

class ShopController extends GetxController {
  final AppNavigation _appNavigation;
  ShopController(this._appNavigation);

  final List<Map<String, dynamic>> parts = [
    {
      'imagePath': AppImages.shop1,
      'name': 'Porsche 911 Matrix LED Headlights',
      'price': '5000',
      'description':'Experience top-notch service at Japtech Auto shop, where we offer a wide range of basic car services to keep your vehicle running smoothly'
    },
    {
      'imagePath': AppImages.shop2,
      'name': 'BMW M5 Turbocharged V8 Engine',
      'price': '6000',
      'description':'Experience top-notch service at Japtech Auto shop, where we offer a wide range of basic car services to keep your vehicle running smoothly'

    },
    {
      'imagePath': AppImages.shop3,
      'name': 'Lamborghini Urus V10 Front Bumper',
      'price': '7000',
      'description':'Experience top-notch service at Japtech Auto shop, where we offer a wide range of basic car services to keep your vehicle running smoothly'

    },
    {
      'imagePath': AppImages.shop1,
      'name': 'Porsche Macan Headlights',
      'price': '102000',
      'description':'Experience top-notch service at Japtech Auto shop, where we offer a wide range of basic car services to keep your vehicle running smoothly'

    },
    {
      'imagePath': AppImages.shop3,
      'name': 'Lamborghini Urus V10 Front Bumper',
      'price': '7000',
      'description':'Experience top-notch service at Japtech Auto shop, where we offer a wide range of basic car services to keep your vehicle running smoothly'

    },
    {
      'imagePath': AppImages.shop1,
      'name': 'Porsche Macan Headlights',
      'price': '102000',
      'description':'Experience top-notch service at Japtech Auto shop, where we offer a wide range of basic car services to keep your vehicle running smoothly'

    },
  ];

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
  }
  void goToProductDetails(String name , String price , String imagePath , String description ){
      _appNavigation.toNamed(ShopPrivateRoutes.productDetails , arguments: {
        'name': name,
        'price': price,
        'imagePath': imagePath,
        'description': description
      });
  }
  void goBack() {
    _appNavigation.goBack();
  }
}
