import 'package:get/get.dart';

import '../domain/repositories/vehicle_finder_repository.dart';
import '../infrastructure/repositoriesImpl/vehicle_finder_repository_impl.dart';

class VehicleFinderDependencies {
  static void init() {
    Get.lazyPut<VehicleFinderRepository>(() => VehicleFinderRepositoryImpl(
        networkService: Get.find()), fenix: true);
  }
}


