import 'package:get/get.dart';
import '../../ui/oderSummary/controllers/oder_summary_controller.dart';

class OderSummaryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OderSummaryController>(() => OderSummaryController(Get.find()));
  }
}
