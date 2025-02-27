import 'package:get/get.dart';
import 'package:jappcare/features/emergency/application/usecases/emergency_usecase.dart';
import 'package:jappcare/features/emergency/domain/entities/emergency.dart';
import 'package:jappcare/features/emergency/domain/repositories/emergency_repository.dart';
import 'package:jappcare/features/emergency/infrastructure/repositoriesImpl/emergency_repository_impl.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/controllers/services_locator_controller.dart';
class EmergencyDependencies {
  static void init() {

    Get.lazyPut<ServicesLocatorController>(() => ServicesLocatorController(Get.find())  , fenix: true );
    Get.lazyPut<EmergencyRepository>(() =>EmergencyRepositoryImpl(networkService: Get.find()));
    Get.lazyPut<EmergencyUseCase>(() => EmergencyUseCase(Get.find()));
    Get.lazyPut(() => Location);

}
}


