import 'package:get/get.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import '../../../../../core/navigation/app_navigation.dart';

import '../../../../../core/utils/getx_extensions.dart';

import '../../../application/usecases/add_vehicle_usecase.dart';
import '../../../application/usecases/add_vehicle_command.dart';
import '../../../../../core/services/form/validators.dart';

import '../../../../../core/services/form/form_helper.dart';

import '../../../domain/core/exceptions/garage_exception.dart';

import '../../../domain/entities/add_vehicle.dart';

class AddVehicleController extends GetxController {
  final AddVehicleUseCase _addVehicleUseCase = Get.find();
  late FormHelper addVehicleFormHelper;

  final AppNavigation _appNavigation;
  AddVehicleController(this._appNavigation);

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    addVehicleFormHelper = FormHelper<GarageException, AddVehicle>(
      fields: {
        "vin": null,
      },
      validators: {
        "vin": Validators.requiredField,
      },
      onSubmit: (data) => _addVehicleUseCase.call(AddVehicleCommand(
        garageId: Get.find<GarageController>().myGarage!.id,
        vin: data['vin']!,
      )),
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (response) {
        Get.find<GarageController>()
            .getVehicleList(Get.find<GarageController>().myGarage!.id);
        _appNavigation.goBack();
      },
    );
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
