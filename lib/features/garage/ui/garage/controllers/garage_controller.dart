import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/events/app_events_service.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/features/workshop/application/command/get_all_appointments_command.dart';
import 'package:jappcare/features/workshop/application/usecases/get_all_appointments_usecase.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';
import '../../../application/usecases/delete_vehicle_usecase.dart';
import '../../../application/command/delete_vehicle_command.dart';
import 'package:jappcare/features/garage/application/command/get_place_name_command.dart';
import 'package:jappcare/features/garage/application/usecases/get_place_name_use_case.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../domain/entities/get_garage_by_owner_id.dart';
import '../../../domain/entities/get_vehicle_list.dart';
import '../../../navigation/private/garage_private_routes.dart';
import '../../../../../core/utils/getx_extensions.dart';
import '../../../application/usecases/get_garage_by_owner_id_usecase.dart';
import '../../../application/command/get_garage_by_owner_id_command.dart';

import '../../../application/usecases/get_vehicle_list_usecase.dart';

import '../widgets/delete_vehicle_widget.dart';

class GarageController extends GetxController {
  final GetVehicleListUseCase _getVehicleListUseCase;
  final DeleteVehicleUseCase _deleteVehicleUseCase = Get.find();
  final GetAllAppointmentsUsecase _getAllAppointmentsUsecase = Get.find();
  final List<String> statusFilters = <String>["All", "Ongoing", "Completed"];

  String? userId;

  final GetPlaceNameUseCase _getPlaceNameUseCase = Get.find();
  final loading = true.obs;
  final vehicleLoading = false.obs;
  final appointmentsLoading = true.obs;
  final vehicleDeleteLoading = false.obs;
  final PageController pageController = PageController(
    viewportFraction: 0.9,
  );
  final selectedAppointStatusFilter = ''.obs;
  final RxInt currentVehiclePage = 0.obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  RxString placeName = ''.obs;
  final GetGarageByOwnerIdUseCase _getGarageByOwnerIdUseCase = Get.find();

  final AppNavigation _appNavigation;
  GarageController(this._appNavigation, this._getVehicleListUseCase);

  GetGarageByOwnerId? myGarage;

  RxList<Vehicle> vehicleList = <Vehicle>[].obs;
  RxList<AppointmentEntity> appointments = <AppointmentEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Écoute des événements
    Get.find<AppEventService>()
        .on<String>(AppConstants.userIdEvent)
        .listen((userId) {
      if (userId != '') fetchData(userId!);
    });

    // Chargement initial des données
    final lastUserId =
        Get.find<AppEventService>().getLastValue(AppConstants.userIdEvent);
    userId = lastUserId;

    if (lastUserId != null) {
      fetchData(lastUserId);
    }

    ever(selectedAppointStatusFilter, (value) {
      getAllAppointments(status: value != "" ? value : null, userId: lastUserId);
    });

    pageController.addListener(() {
      int newPage = pageController.page!.round();
      if (currentVehiclePage.value != newPage) {
        currentVehiclePage.value = newPage;
      }
    });
  }

  // Méthode pour récupérer les données
  Future<void> fetchData(String userId) async {
    loading.value = true;
    vehicleLoading.value = true;

    try {
      await getVehicleList(ownerId: userId);
      await getAllAppointments(userId: userId);
      update();
      // await getGarageByOwnerId(userId);
    } catch (e) {
      print("Erreur lors de la récupération des données : $e");
    } finally {
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
    print("View car details");
    _appNavigation.toNamed(GaragePrivateRoutes.vehicleDetails,
        arguments: vehicleDetails);
  }

  void goToAppointmentDetail(AppointmentEntity appointmentDetails) {
    _appNavigation.toNamed(AppRoutes.appointmentDetails,
        arguments: appointmentDetails);
  }

  Future<void> deleteVehicle(String id) async {
    vehicleDeleteLoading.value = true;
    final result =
        await _deleteVehicleUseCase.call(DeleteVehicleCommand(id: id));
    result.fold(
      (e) {
        vehicleDeleteLoading.value = false;
        Get.showCustomSnackBar(e.message);
      },
      (success) {
        vehicleDeleteLoading.value = false;
        Get.back();
        Get.find<GarageController>()
            .getVehicleList(ownerId: userId);
      },
    );
  }

  void openDeleteVehicle(Vehicle vehicleDetails) {
    openDeleteVehicleModal(vehicleDetails, () {
      deleteVehicle(vehicleDetails.id);
    });
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
        getVehicleList(ownerId: userId);
        getAllAppointments(userId: userId);
        Get.find<AppEventService>()
            .emit<String>(AppConstants.garageIdEvent, myGarage!.id);
        update();
        loading.value = false;
      },
    );
  }

  Future<void> getPlaceName(double longitude, double latitude) async {
    lat.value = latitude;
    long.value = longitude;
    final result = await _getPlaceNameUseCase
        .call(GetPlaceNameCommand(longitude: longitude, latitude: latitude));
    result.fold((error) {
      debugPrint(error.message);
    }, (response) {
      placeName.value = response;
      update();
    });
  }

  Future<void> getVehicleList({String? ownerId}) async {
    vehicleLoading.value = true;
    final result = await _getVehicleListUseCase.call(userId: ownerId);
    result.fold(
      (e) {
        vehicleLoading.value = false;
        Get.showCustomSnackBar(e.message);
      },
      (response) {
        vehicleList.value = response.reversed.toList();
        update();
        vehicleLoading.value = false;
      },
    );
  }

  Future<void> getAllAppointments({String? status, String? userId}) async {
    appointmentsLoading.value = true;
    final result = await _getAllAppointmentsUsecase.call(
        command: GetAllAppointmentsCommand(
            status: status, userId: userId));
    result.fold(
      (e) {
        appointmentsLoading.value = false;
        if (Get.context != null) {
          Get.showCustomSnackBar(e.message);
        }
      },
      (response) {
        appointmentsLoading.value = false;
        appointments.value = response;
      },
    );
  }
}

void openDeleteVehicleModal(Vehicle vehicleDetails, Function onConfirm) {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true, // Permet un contrôle précis sur la hauteur
    backgroundColor: Colors.transparent, // Rendre l'arrière-plan transparent
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16), // Espacement intérieur
          child: Wrap(
            children: [
              DeleteVehicleWidget(onConfirm: () {
                onConfirm();
              }),
            ],
          ),
        ),
      );
    },
  );
}
