import 'package:get/get.dart';
import '../../ui/productDetails/controllers/product_details_controller.dart';

class ProductDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailsController>(() => ProductDetailsController(Get.find()));
  }
}
