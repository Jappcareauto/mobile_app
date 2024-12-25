import 'package:get/get.dart';
import '../../ui/vehicleFinder/controllers/vehicle_finder_controller.dart';

class VehicleFinderControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleFinderController>(() => VehicleFinderController(Get.find()));
  }
}
