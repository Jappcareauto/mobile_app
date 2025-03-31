import 'dart:async';

import 'package:get/get.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/features/workshop/domain/core/exceptions/workshop_exception.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services_center.dart';
import 'package:jappcare/features/workshop/domain/entities/get_allservices.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:jappcare/features/workshop/application/usecases/get_service_center_command.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/utils/getx_extensions.dart';
import '../../../application/usecases/get_all_services_center_usecase.dart';
import '../../../application/usecases/get_allservices_usecase.dart';

class WorkshopController extends GetxController {
  final GetAllservicesUseCase _getAllservicesUseCase =
      Get.find(); // Get.find() is an instance method used to get a class
  final globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();
  final loading = false.obs;
  final serviceloading = false.obs;

  var serviceCenterName = "".obs;
  late FormHelper getServiceCentersFormHelper;

  final GetAllServicesCenterUseCase _getAllServicesCenterUseCase = Get.find();

  Rxn<GetAllServicesCenter> servicesCenter = Rxn<GetAllServicesCenter>();
  Rxn<GetAllservices> services = Rxn<GetAllservices>();

  final AppNavigation _appNavigation;
  WorkshopController(this._appNavigation);
  var selectedFilter = 0.obs;
  var selectedCategory = "".obs;
  final selectedCategoryIndex = 0.obs;
  var servicesId = "".obs;

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required.";
    }
    return null; // No error
  }

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    getAllservices();
    getAllServicesCenter();
    ever(services, (serviceModel) {
      if (serviceModel != null && serviceModel.data.isNotEmpty) {
        selectedFilter.value = 0;
        selectedCategory.value = serviceModel.data.first.title ?? "Sans titre";
      }
    });
    getServiceCentersFormHelper =
        FormHelper<WorkshopException, GetAllServicesCenter>(
      fields: {
        "name": null,
      },

      // validators: {
      //   "vin": validateVin,
      //   "registration": Validators.requiredField,
      // },
      // onSubmit: (data) {
      //   return _getAllservicesUseCase.call(AddVehicleCommand(
      //       garageId: Get.find<GarageController>().myGarage!.id,
      //       vin: data['vin']!,
      //       registrationNumber: data['registration']!));
      // },
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (response) {
        // Get.find<GarageController>()
        //     .getVehicleList(Get.find<GarageController>().myGarage!.id);
        // _appNavigation.goBack();
      },
    );

    // Listen for VIN input changes
    getServiceCentersFormHelper.controllers['name']?.addListener(() {
      serviceCenterName.value =
          getServiceCentersFormHelper.controllers['name']!.text;
    });

    debounce(serviceCenterName, (value) {
      if (value.isNotEmpty) {
        getAllServicesCenter(name: serviceCenterName.value);
      }
    }, time: const Duration(seconds: 2));

    debounce(selectedFilter, (value) {
      if (value >= 0) {
        getAllServicesCenter(
            name: serviceCenterName.value,
            serviceId: servicesCenter.value?.data[selectedFilter.value].id);
      }
    }, time: const Duration(seconds: 1));
  }

  void gotToServicesLocator() {
    _appNavigation.toNamed(WorkshopPrivateRoutes.sevicesLocator);
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void goToWorkshopDetails(String name, String description, double latitude,
      double longitude, String id, bool availability, String? locationName) {
    _appNavigation.toNamed(WorkshopPrivateRoutes.workshopDetails,
        arguments: services);
    globalControllerWorkshop.addMultipleData({
      "serviceCenterName": name,
      "description": description,
      "latitude": latitude,
      "longitude": longitude,
      "locationName": locationName,
      "servciceId": servicesId.value,
      "serviceCenterId": id,
      "availability": availability
    });
  }

  Future<void> getAllServicesCenter({String? name, String? serviceId}) async {
    loading.value = true;
    final result = await _getAllServicesCenterUseCase
        .call(GetServiceCenterCommand(name: name, serviceCenterId: serviceId));
    result.fold(
      (e) {
        loading.value = false;
        if (Get.context != null) {
          Get.showCustomSnackBar(e.message);
        }
      },
      (response) {
        loading.value = false;
        servicesCenter.value = response;
        print(response.data);
      },
    );
  }

  Future<void> getAllservices() async {
    serviceloading.value = true;
    final result = await _getAllservicesUseCase.call();
    result.fold(
      (e) {
        serviceloading.value = false;
        if (Get.context != null) {
          Get.showCustomSnackBar(e.message);
        }
      },
      (response) {
        serviceloading.value = false;
        services.value = response;
        print(response);
      },
    );
  }
}
