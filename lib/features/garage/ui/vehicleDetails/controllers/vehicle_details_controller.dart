import 'package:get/get.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import '../../../../../core/navigation/app_navigation.dart';

class VehicleDetailsController extends GetxController {
  final AppNavigation _appNavigation;
  VehicleDetailsController(this._appNavigation);

  late GetVehicleList vehicleModel;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    vehicleModel = Get.arguments;
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
