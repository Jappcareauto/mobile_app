import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/service_center_locator/controllers/services_locator_controller.dart';

import '../domain/repositories/emergency_repository.dart';
import '../infrastructure/repositoriesImpl/emergency_repository_impl.dart';

class EmergencyDependencies {
  static void init() {
    Get.lazyPut<EmergencyRepository>(() => EmergencyRepositoryImpl(
        networkService: Get.find()), fenix: true);
    Get.lazyPut<ServicesLocatorController>(() => ServicesLocatorController(Get.find())  , fenix: true);
  }
}


