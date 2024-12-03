import 'package:get/get.dart';

import '../domain/repositories/chat_repository.dart';
import '../infrastructure/repositoriesImpl/chat_repository_impl.dart';

class ChatDependencies {
  static void init() {
    Get.lazyPut<ChatRepository>(() => ChatRepositoryImpl(
        networkService: Get.find()), fenix: true);
  }
}


