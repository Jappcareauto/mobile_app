import 'package:get/get.dart';
import 'package:jappcare/features/chat/ui/chat/controllers/chat_details_controller.dart';

class ChatDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatDetailsController>(() => ChatDetailsController(Get.find()));
  }
}
