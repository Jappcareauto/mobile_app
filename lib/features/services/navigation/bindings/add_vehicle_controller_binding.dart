import 'package:get/get.dart';
import '../../ui/addVehicle/controllers/add_vehicle_controller.dart';

class AddVehicleControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddVehicleController>(() => AddVehicleController(Get.find()));
  }
}
