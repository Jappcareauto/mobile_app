import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
import 'package:jappcare/features/workshop/domain/core/exceptions/workshop_exception.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services_center.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:jappcare/features/workshop/application/command/get_service_center_command.dart';
import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/utils/getx_extensions.dart';
import '../../../application/usecases/get_all_services_center_usecase.dart';
import '../../../application/usecases/get_all_services_usecase.dart';

class WorkshopController extends GetxController {
  final GetAllservicesUseCase _getAllservicesUseCase =
      Get.find(); // Get.find() is an instance method used to get a class
  final globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();
  final loading = false.obs;
  final serviceloading = false.obs;

  var serviceCenterName = "".obs;
  var selectedService = (-1).obs;
  var selectedCategory = "".obs;
  final selectedCategoryIndex = 0.obs;
  var servicesId = "".obs;
  var aroundMe = false.obs;
  var availableNow = false.obs;

  late FormHelper getServiceCentersFormHelper;

  final GetAllServicesCenterUseCase _getAllServicesCenterUseCase = Get.find();

  Rxn<GetAllServicesCenter> servicesCenter = Rxn<GetAllServicesCenter>();
  Rxn<GetAllservices> services = Rxn<GetAllservices>();

  final AppNavigation _appNavigation;
  WorkshopController(this._appNavigation);

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
    // ever(services, (serviceModel) {
    //   if (serviceModel != null && serviceModel.data.isNotEmpty) {
    //     selectedFilter.value = 0;
    //     selectedCategory.value = serviceModel.data.first.title;
    //   }
    // });

    debounce(serviceCenterName, (value) {
      filterServiceCenters(
          input: value.isNotEmpty ? value : null,
          serviceId: selectedService.value,
          aroundMe: aroundMe.value,
          availableNow: availableNow.value);
    }, time: const Duration(seconds: 2));

    debounce(selectedService, (value) {
      if (value >= 0 || value == -1) {
        filterServiceCenters(
            input: serviceCenterName.value,
            serviceId: value,
            aroundMe: aroundMe.value,
            availableNow: availableNow.value);
      }
    }, time: const Duration(seconds: 1));

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
          getServiceCentersFormHelper.controllers['name']!.text.toLowerCase();
    });
  }

  void gotToServicesLocator() {
    _appNavigation.toNamed(WorkshopPrivateRoutes.sevicesLocator);
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void goToWorkshopDetails(
      {String? name,
      List<ServiceEntity>? centerServices,
      String? description,
      double? latitude,
      double? longitude,
      required String id,
      bool? availability,
      String? locationName}) {
    _appNavigation.toNamed(WorkshopPrivateRoutes.workshopDetails,
        arguments: centerServices);
    globalControllerWorkshop.addMultipleData({
      "serviceCenterName": name,
      "description": description,
      "latitude": latitude,
      "longitude": longitude,
      "locationName": locationName,
      "serviceId": servicesId.value,
      "serviceCenterId": id,
      "availability": availability,
      "centerServices": centerServices
    });
  }

  void filterServiceCenters(
      {String? input,
      required int serviceId,
      bool? aroundMe,
      bool? availableNow}) {
    getAllServicesCenter(
        name: input != "" ? input : null,
        serviceId: serviceId == -1 ? null : services.value?.data[serviceId].id);
  }

  Future<void> getAllServicesCenter(
      {String? name,
      String? serviceId,
      bool? aroundMe,
      bool? availableNow}) async {
    loading.value = true;
    final result = await _getAllServicesCenterUseCase.call(
        GetServiceCenterCommand(
            name: name,
            serviceCenterId: serviceId,
            aroundMe: aroundMe,
            availableNow: availableNow));
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
      },
    );
  }

  Future<void> showFiltersDialog() {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filters by research'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 5,
                children: [
                  GestureDetector(
                    onTap: () {
                      aroundMe.value = !aroundMe.value;
                    },
                    child: Obx(() {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: aroundMe.value
                                ? Get.theme.primaryColor
                                : Get.theme.unselectedWidgetColor),
                        child: Text(
                          'Around Me',
                          style: Get.textTheme.bodyMedium?.copyWith(
                              color: Get.theme.scaffoldBackgroundColor),
                        ),
                      );
                    }),
                  ),
                  GestureDetector(
                    onTap: () {
                      availableNow.value = !availableNow.value;
                    },
                    child: Obx(() {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: availableNow.value
                                ? Get.theme.primaryColor
                                : Get.theme.unselectedWidgetColor),
                        child: Text(
                          'Available Now',
                          style: Get.textTheme.bodyMedium?.copyWith(
                              color: Get.theme.scaffoldBackgroundColor),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Get.back(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Clear'),
              onPressed: () {
                aroundMe.value = false;
                availableNow.value = false; // Close the dialog
                filterServiceCenters(
                    input: serviceCenterName.value,
                    serviceId: selectedService.value,
                    aroundMe: false,
                    availableNow: false);
              },
            ),
            TextButton(
              child: const Text('Apply'),
              onPressed: () {
                filterServiceCenters(
                    input: serviceCenterName.value,
                    serviceId: selectedService.value,
                    aroundMe: aroundMe.value,
                    availableNow: availableNow.value);
                Get.back(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
