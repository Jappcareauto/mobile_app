import 'package:get/get.dart';
import '../../ui/networkError/controllers/network_error_controller.dart';

class NetworkErrorControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkErrorController>(() => NetworkErrorController(Get.find()));
  }
}
