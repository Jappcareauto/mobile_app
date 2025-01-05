import 'package:get/get.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/features/shop/navigation/private/shop_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

import '../../../../../core/utils/getx_extensions.dart';

import '../../../application/usecases/get_products_usecase.dart';

class ShopController extends GetxController {
  final GetProductsUseCase _getProductsUseCase = Get.find();
  final loading = false.obs;

  final AppNavigation _appNavigation;
  ShopController(this._appNavigation);
  List<String>  categorie = [ 'All' , 'Accesories' , 'Lubricants & Fluids' , 'Tires & Wheels'] ;
  RxInt selectedFilter = 0.obs;
  final RxString selectedCategory = 'All'.obs;

  final List<Map<String, dynamic>> parts = [
    {
      'imagePath': AppImages.shop1,
      'name': 'Porsche 911 Matrix LED Headlights',
      'price': '5000',
      'category': 'Accesories',
      'description':'Experience top-notch service at Japtech Auto shop, where we offer a wide range of basic car services to keep your vehicle running smoothly'
    },
    {
      'imagePath': AppImages.shop2,
      'name': 'BMW M5 Turbocharged V8 Engine',
      'price': '6000',
      'description':'Experience top-notch service at Japtech Auto shop, where we offer a wide range of basic car services to keep your vehicle running smoothly',
      'category': 'Lubricants & Fluids',

    },
    {
      'imagePath': AppImages.shop3,
      'name': 'Lamborghini Urus V10 Front Bumper',
      'price': '7000',
      'category': 'Accesories',

      'description':'Experience top-notch service at Japtech Auto shop, where we offer a wide range of basic car services to keep your vehicle running smoothly'

    },
    {
      'imagePath': AppImages.shop1,
      'name': 'Porsche Macan Headlights',
      'price': '102000',
      'description':'Experience top-notch service at Japtech Auto shop, where we offer a wide range of basic car services to keep your vehicle running smoothly',
      'category': 'Tires & Wheels',

    },
    {
      'imagePath': AppImages.shop3,
      'name': 'Lamborghini Urus V10 Front Bumper',
      'price': '7000',
      'category': 'Lubricants & Fluids',

      'description':'Experience top-notch service at Japtech Auto shop, where we offer a wide range of basic car services to keep your vehicle running smoothly'

    },
    {
      'imagePath': AppImages.shop1,
      'name': 'Porsche Macan Headlights',
      'price': '102000',
      'category': 'Tires & Wheels',

      'description':'Experience top-notch service at Japtech Auto shop, where we offer a wide range of basic car services to keep your vehicle running smoothly'

    },
  ];

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    getProducts();

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
  List<Map<String, dynamic>> get filteredParts {
    if (selectedCategory.value == 'All') {
      return parts; // Affiche tous les produits si aucune catégorie n'est sélectionnée.
    }
    return parts.where((part) => part['category'] == selectedCategory.value).toList();
  }

  Future<void> getProducts() async {
    loading.value = true;
    final result = await _getProductsUseCase.call(
      
    );
    result.fold(
      (e) {
         loading.value = false;
         if(Get.context !=null)
            Get.showCustomSnackBar(e.message);
      },
      (response) {
        loading.value = false;
        print(response);
      },
    );
  }

}
