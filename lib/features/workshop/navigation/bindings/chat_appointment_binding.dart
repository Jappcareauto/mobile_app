import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/chat/controllers/chat_controller.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';

class ChatAppointmentBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<ChatController>(() =>ChatController(Get.find()));
  }
}