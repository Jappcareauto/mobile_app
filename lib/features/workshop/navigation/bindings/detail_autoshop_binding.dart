import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/autoshop_detail/controllers/autoshop_controller.dart';


class DetailAutoshopBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<AutoShopController>(() => AutoShopController(Get.find()));

  }
}
