import 'package:get/get.dart';
import '../../ui/history/controllers/history_controller.dart';

class HistoryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryController>(() => HistoryController(Get.find()));
  }
}
