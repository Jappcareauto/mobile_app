import 'package:get/get.dart';
import '../../ui/odersummary2/controllers/odersummary2_controller.dart';

class Odersummary2ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Odersummary2Controller>(() => Odersummary2Controller(Get.find()));
  }
}
