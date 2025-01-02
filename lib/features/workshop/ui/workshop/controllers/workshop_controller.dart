import 'package:get/get.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import '../../../../../core/navigation/app_navigation.dart';

import '../../../../../core/utils/getx_extensions.dart';

import '../../../application/usecases/get_all_services_center_usecase.dart';
class WorkshopController extends GetxController {
  final GetAllServicesCenterUseCase _getAllServicesCenterUseCase = Get.find();
  final loading = false.obs;

  final AppNavigation _appNavigation;
  WorkshopController(this._appNavigation);

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

  void goToWorkshopDetails() {
    _appNavigation.toNamed(WorkshopPrivateRoutes.workshopDetails);
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
        print(response);
      },
    );
  }

}
