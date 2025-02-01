import 'package:get/get.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services_center.dart';
import 'package:jappcare/features/workshop/domain/entities/get_allservices.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

import '../../../../../core/utils/getx_extensions.dart';

import '../../../application/usecases/get_all_services_center_usecase.dart';

import '../../../application/usecases/get_allservices_usecase.dart';

class WorkshopController extends GetxController {
  final GetAllservicesUseCase _getAllservicesUseCase = Get.find();
  final globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();
  final loading = false.obs;
  final serviceloading = false.obs;


  final GetAllServicesCenterUseCase _getAllServicesCenterUseCase = Get.find();

  Rxn<GetAllServicesCenter> servicesCenter = Rxn<GetAllServicesCenter>();
  Rxn<GetAllservices> services = Rxn<GetAllservices>();

  final AppNavigation _appNavigation;
  WorkshopController(this._appNavigation );
  var selectedFilter = 0.obs;
  var selectedCategory = "".obs;
  final selectedCategoryIndex = 0.obs;
  var servicesId  = "".obs ;
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
  }
  void gotToServicesLocator () {
    _appNavigation.toNamed(WorkshopPrivateRoutes.sevicesLocator);
  }
  void goBack() {
    _appNavigation.goBack();
  }

  void goToWorkshopDetails(String name , String description , double latitude , double longitude , String id) {
    _appNavigation.toNamed(WorkshopPrivateRoutes.workshopDetails , arguments: services);
    globalControllerWorkshop.addMultipleData({
      "serviceCenterName": name ,
      "description": description ,
      "latitude": latitude ,
      "longitude":longitude,
      "servciceId":servicesId.value,
      "serviceCenterId":id
    });
  }
  Future<void> getAllServicesCenter() async {
    loading.value = true;
    final result = await _getAllServicesCenterUseCase.call();
    result.fold(
      (e) {
         loading.value = false;
         if(Get.context !=null)
            Get.showCustomSnackBar(e.message);
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
         if(Get.context !=null)
            Get.showCustomSnackBar(e.message);
      },
      (response) {
        serviceloading.value = false;
        services.value = response ;
        print(response);
      },
    );
  }

}
