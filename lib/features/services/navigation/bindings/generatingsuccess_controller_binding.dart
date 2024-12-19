import 'package:get/get.dart';
import '../../ui/generatingsuccess/controllers/generatingsuccess_controller.dart';

class GeneratingsuccessControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneratingsuccessController>(() => GeneratingsuccessController(Get.find()));
  }
}
