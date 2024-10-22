import 'package:get/get.dart';
import '../../ui/shop/controllers/shop_controller.dart';

class ShopControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopController>(() => ShopController(Get.find()));
  }
}
