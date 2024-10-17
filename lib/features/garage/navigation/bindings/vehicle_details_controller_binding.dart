import 'package:get/get.dart';
import '../../ui/vehicleDetails/controllers/vehicle_details_controller.dart';

class VehicleDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleDetailsController>(() => VehicleDetailsController(Get.find()));
  }
}
