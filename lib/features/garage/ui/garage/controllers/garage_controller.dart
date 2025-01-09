import 'package:get/get.dart';
import 'package:jappcare/core/events/app_events_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/features/garage/application/usecases/get_place_name_command.dart';
import 'package:jappcare/features/garage/application/usecases/get_place_name_use_case.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../domain/entities/get_garage_by_owner_id.dart';
import '../../../domain/entities/get_vehicle_list.dart';
import '../../../navigation/private/garage_private_routes.dart';
import '../../../../../core/utils/getx_extensions.dart';
import '../../../application/usecases/get_garage_by_owner_id_usecase.dart';
import '../../../application/usecases/get_garage_by_owner_id_command.dart';

import '../../../application/usecases/get_vehicle_list_usecase.dart';
import '../../../application/usecases/get_vehicle_list_command.dart';

class GarageController extends GetxController {
  final GetVehicleListUseCase _getVehicleListUseCase;

  final GetPlaceNameUseCase _getPlaceNameUseCase = Get.find();
  final loading = true.obs;
  final vehicleLoading = true.obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  RxString placeName = ''.obs;
  final GetGarageByOwnerIdUseCase _getGarageByOwnerIdUseCase = Get.find();

  final AppNavigation _appNavigation;
  GarageController(this._appNavigation , this._getVehicleListUseCase);

  GetGarageByOwnerId? myGarage;

  RxList<Vehicle> vehicleList = <Vehicle>[].obs;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    Get.find<AppEventService>()
        .on<String>(AppConstants.userIdEvent)
        .listen((userId) {
      if (userId != '') getGarageByOwnerId(userId!);
    });
    if (Get.find<AppEventService>().getLastValue(AppConstants.userIdEvent) !=
        null) {
      loading.value = false;
      vehicleLoading.value = false;
    }
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void goToAddVehicle() {
    _appNavigation.toNamed(GaragePrivateRoutes.addVehicle);
  }

  void goToVehicleDetails(Vehicle vehicleDetails) {
    _appNavigation.toNamed(GaragePrivateRoutes.vehicleDetails,
        arguments: vehicleDetails);
  }

  Future<void> getGarageByOwnerId(String userId) async {

    loading.value = true;
    final result = await _getGarageByOwnerIdUseCase
        .call(GetGarageByOwnerIdCommand(userId: userId));
    result.fold(
      (e) {
        loading.value = false;
        Get.showCustomSnackBar(e.message);
      },
      (success) {
        myGarage = success;
        getVehicleList(myGarage!.id);
        Get.find<AppEventService>()
            .emit<String>(AppConstants.garageIdEvent, myGarage!.id);
        update();
        loading.value = false;
      },
    );
  }
  Future<void> getPlaceName(double longitude , double latitude) async{
    lat.value = latitude;
    long.value = longitude;
     final result  = await _getPlaceNameUseCase.call(GetPlaceNameCommand(longitude: longitude, latitude: latitude));
     result.fold(
         (error){
           print(error.message);
         },
         (response){
           placeName.value = response ;
           update();
         }

     );
  }

  Future<void> getVehicleList(String garageId) async {
    vehicleLoading.value = true;
    final result = await _getVehicleListUseCase
        .call(GetVehicleListCommand(garageId: garageId));
    result.fold(
      (e) {
        vehicleLoading.value = false;
        Get.showCustomSnackBar(e.message);
      },
      (response) {
        vehicleList.value = response;
        print("vehicleList.toList()");


        update();
        vehicleLoading.value = false;
      },
    );
  }
}
