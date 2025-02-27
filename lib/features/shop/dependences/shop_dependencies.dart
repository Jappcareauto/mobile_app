import 'package:get/get.dart';
import 'package:jappcare/features/shop/ui/bag/controllers/bag_controller.dart';

import '../../../core/ui/interfaces/feature_widget_interface.dart';
import '../domain/repositories/shop_repository.dart';
import '../infrastructure/repositoriesImpl/shop_repository_impl.dart';
import '../ui/shop/shop_screen.dart';

import '../application/usecases/get_products_usecase.dart';

class ShopDependencies {
  static void init() {
    Get.lazyPut<ShopRepository>(() => ShopRepositoryImpl(
        networkService: Get.find()), fenix: true);
    Get.lazyPut<FeatureWidgetInterface>(() => const ShopScreen(),
        tag: 'ShopScreen', fenix: true);
      Get.lazyPut(() => GetProductsUseCase(Get.find()), fenix: true);
    Get.put(BagController(Get.find()), permanent: true);
}
}


