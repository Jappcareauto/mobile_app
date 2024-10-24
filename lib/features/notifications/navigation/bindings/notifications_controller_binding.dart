import 'package:get/get.dart';
import '../../ui/notifications/controllers/notifications_controller.dart';

class NotificationsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationsController>(() => NotificationsController(Get.find()));
  }
}
