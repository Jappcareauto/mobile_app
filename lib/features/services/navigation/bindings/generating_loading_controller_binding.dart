import 'package:get/get.dart';
import '../../ui/generatingLoading/controllers/generating_loading_controller.dart';

class GeneratingLoadingControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneratingLoadingController>(() => GeneratingLoadingController(Get.find()));
  }
}
