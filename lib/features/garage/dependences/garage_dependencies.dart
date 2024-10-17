import 'package:get/get.dart';

import '../domain/repositories/garage_repository.dart';
import '../infrastructure/repositoriesImpl/garage_repository_impl.dart';

class GarageDependencies {
  static void init() {
    Get.lazyPut<GarageRepository>(() => GarageRepositoryImpl(
        networkService: Get.find()), fenix: true);
  }
}


