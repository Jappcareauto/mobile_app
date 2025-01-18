import 'package:get/get.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services_center.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

import '../../../../../core/utils/getx_extensions.dart';

import '../../../application/usecases/get_all_services_center_usecase.dart';
class WorkshopController extends GetxController {
  final GetAllServicesCenterUseCase _getAllServicesCenterUseCase = Get.find();
  final loading = false.obs;
  Rxn<GetAllServicesCenter> servicesCenter = Rxn<GetAllServicesCenter>();
  final AppNavigation _appNavigation;
  WorkshopController(this._appNavigation );

  final selectedCategoryIndex = 0.obs;

  @override
  void onInit() {
    // Generate by Menosi_cli
    super.onInit();
    getAllServicesCenter();
  }
  void gotToServicesLocator () {
    _appNavigation.toNamed(WorkshopPrivateRoutes.sevicesLocator);
  }
  void goBack() {
    _appNavigation.goBack();
  }

  void goToWorkshopDetails(String name , String description , double latitude , double longitude , String id) {
    _appNavigation.toNamed(WorkshopPrivateRoutes.workshopDetails , arguments: {
      "name": name ,
      "description": description ,
      "latitude": latitude ,
      "longitude":longitude,
      "id":id
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

}
