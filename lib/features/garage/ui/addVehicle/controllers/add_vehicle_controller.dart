import 'package:get/get.dart';
import 'package:jappcare/features/garage/ui/garage/controllers/garage_controller.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import '../../../../../core/navigation/app_navigation.dart';

import '../../../../../core/utils/getx_extensions.dart';

import '../../../application/usecases/add_vehicle_usecase.dart';
import '../../../application/usecases/add_vehicle_command.dart';
import '../../../../../core/services/form/validators.dart';

import '../../../../../core/services/form/form_helper.dart';

import '../../../domain/core/exceptions/garage_exception.dart';

import '../../../domain/entities/get_vehicle_list.dart';

class AddVehicleController extends GetxController {
  final AddVehicleUseCase _addVehicleUseCase =
      Get.find(); // Reactive variable to track character count
  var vinCharacterCount = 0.obs;
  late FormHelper addVehicleFormHelper;
  final globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();

  RxString serviceCenterId = ''.obs;

  final AppNavigation _appNavigation;
  AddVehicleController(this._appNavigation);

  String? validateVin(String? value) {
    if (value == null || value.isEmpty) {
      return "VIN is required.";
    }
    if (!RegExp(r'^[A-HJ-NPR-Z0-9]{17}$').hasMatch(value)) {
      return "Invalid VIN. Must be 17 characters and contain only A-Z (except I, O, Q) and 0-9.";
    }
    return null; // No error
  }

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();

    serviceCenterId.value =
        globalControllerWorkshop.workshopData['serviceCenterId'];

    print(globalControllerWorkshop.workshopData['serviceCenterId']);

    addVehicleFormHelper = FormHelper<GarageException, Vehicle>(
      fields: {
        "vin": null,
        "registration": null,
      },
      validators: {
        "vin": validateVin,
        "registration": Validators.requiredField,
      },
      onSubmit: (data) {
        return _addVehicleUseCase.call(AddVehicleCommand(
            serviceCenterId: serviceCenterId.value,
            vin: data['vin']!,
            registrationNumber: data['registration']!));
      },
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (response) {
        Get.find<GarageController>()
            .getVehicleList(Get.find<ProfileController>().userInfos!.id);
        _appNavigation.goBack();
      },
    );
    // Listen for VIN input changes
    addVehicleFormHelper.controllers['vin']?.addListener(() {
      vinCharacterCount.value =
          addVehicleFormHelper.controllers['vin']!.text.length;
    });
  }

  void goBack() {
    _appNavigation.goBack();
  }
}
