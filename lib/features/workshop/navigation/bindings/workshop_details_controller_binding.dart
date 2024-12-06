import 'package:get/get.dart';
import '../../ui/workshopDetails/controllers/workshop_details_controller.dart';

class WorkshopDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkshopDetailsController>(() => WorkshopDetailsController(Get.find()));
  }
}
