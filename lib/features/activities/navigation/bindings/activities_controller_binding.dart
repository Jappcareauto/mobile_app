import 'package:get/get.dart';
import '../../ui/activities/controllers/activities_controller.dart';

class ActivitiesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivitiesController>(() => ActivitiesController(Get.find()));
  }
}
