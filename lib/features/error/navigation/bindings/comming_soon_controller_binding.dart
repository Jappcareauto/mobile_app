import 'package:get/get.dart';
import '../../ui/commingSoon/controllers/comming_soon_controller.dart';

class CommingSoonControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommingSoonController>(() => CommingSoonController(Get.find()));
  }
}
