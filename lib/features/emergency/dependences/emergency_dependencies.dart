import 'package:get/get.dart';

import '../domain/repositories/emergency_repository.dart';
import '../infrastructure/repositoriesImpl/emergency_repository_impl.dart';

class EmergencyDependencies {
  static void init() {
    Get.lazyPut<EmergencyRepository>(() => EmergencyRepositoryImpl(
        networkService: Get.find()), fenix: true);
  }
}


