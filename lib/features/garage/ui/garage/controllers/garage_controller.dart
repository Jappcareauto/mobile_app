import 'package:get/get.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../domain/entities/get_garage_by_owner_id.dart';
import '../../../navigation/private/garage_private_routes.dart';

import '../../../../../core/utils/getx_extensions.dart';

import '../../../application/usecases/get_garage_by_owner_id_usecase.dart';
import '../../../application/usecases/get_garage_by_owner_id_command.dart';

class GarageController extends GetxController {
  final GetGarageByOwnerIdUseCase _getGarageByOwnerIdUseCase = Get.find();

  final AppNavigation _appNavigation;
  GarageController(this._appNavigation);

  final __localStorageService = Get.find<LocalStorageService>();
  final loading = false.obs;
  GetGarageByOwnerId? myGarage;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    getGarageByOwnerId();
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void goToAddVehicle() {
    _appNavigation.toNamed(GaragePrivateRoutes.addVehicle);
  }

  void goToVehicleDetails() {
    _appNavigation.toNamed(GaragePrivateRoutes.vehicleDetails);
  }

  Future<void> getGarageByOwnerId() async {
    loading.value = true;
    final result = await _getGarageByOwnerIdUseCase.call(
        GetGarageByOwnerIdCommand(
            userId: __localStorageService.read(AppConstants.userIdKey)));
    result.fold(
      (e) {
        loading.value = false;
        Get.showCustomSnackBar(e.message);
      },
      (success) {
        loading.value = false;
        myGarage = success;
        update();
      },
    );
  }
}
