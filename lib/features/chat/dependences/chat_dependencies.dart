import 'package:get/get.dart';

import '../domain/repositories/chat_repository.dart';
import '../infrastructure/repositoriesImpl/chat_repository_impl.dart';
import '../application/usecases/get_all_chatrooms.usecase.dart';
import '../application/usecases/get_chatroom_by_appointment_id.usecase.dart';
import '../application/usecases/send_message.usecase.dart';

class ChatDependencies {
  static void init() {
    Get.lazyPut<ChatRepository>(
        () => ChatRepositoryImpl(networkService: Get.find()),
        fenix: true);

    Get.lazyPut(() => GetChatRoomByAppoitmentIdUseCase(Get.find()),
        fenix: true);
    Get.lazyPut(() => GetAllChatRoomsUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SendMessageUseCase(Get.find()), fenix: true);
  }
}
