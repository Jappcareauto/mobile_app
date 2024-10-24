import 'package:get/get.dart';

import '../domain/repositories/notifications_repository.dart';
import '../infrastructure/repositoriesImpl/notifications_repository_impl.dart';

class NotificationsDependencies {
  static void init() {
    Get.lazyPut<NotificationsRepository>(() => NotificationsRepositoryImpl(
        networkService: Get.find()), fenix: true);
  }
}


