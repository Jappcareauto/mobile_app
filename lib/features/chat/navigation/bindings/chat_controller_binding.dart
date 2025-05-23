import 'package:get/get.dart';
import 'package:jappcare/features/chat/ui/chat/controllers/chat_controller.dart';

class ChatControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController(Get.find()));
  }
}
