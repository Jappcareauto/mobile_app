import 'package:get/get.dart';

import '../domain/repositories/home_repository.dart';
import '../domain/localStorage/home_local_storage.dart';
import '../infrastructure/repositoriesImpl/home_repository_impl.dart';
import '../infrastructure/localStorageImpl/home_local_storage_impl.dart';

class HomeDependencies {
  static void init() {
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(
        networkService: Get.find()), fenix: true);
    Get.lazyPut<HomeLocalStorage>(() => HomeLocalStorageImpl(
        localStorageService: Get.find()), fenix: true);
  }
}
