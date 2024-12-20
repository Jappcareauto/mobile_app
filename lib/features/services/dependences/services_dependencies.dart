import 'package:get/get.dart';

import '../domain/repositories/services_repository.dart';
import '../infrastructure/repositoriesImpl/services_repository_impl.dart';

class ServicesDependencies {
  static void init() {
    Get.lazyPut<ServicesRepository>(() => ServicesRepositoryImpl(
        networkService: Get.find()), fenix: true);
  }
}


