import 'package:get/get.dart';

import '../../../core/ui/interfaces/feature_widget_interface.dart';
import '../domain/repositories/shop_repository.dart';
import '../infrastructure/repositoriesImpl/shop_repository_impl.dart';
import '../ui/shop/shop_screen.dart';

class ShopDependencies {
  static void init() {
    Get.lazyPut<ShopRepository>(() => ShopRepositoryImpl(
        networkService: Get.find()), fenix: true);
    Get.lazyPut<FeatureWidgetInterface>(() => ShopScreen(),
        tag: 'ShopScreen', fenix: true);
  }
}


