import 'package:get/get.dart';
import '../../ui/notificationDetails/controllers/notification_details_controller.dart';

class NotificationDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationDetailsController>(() => NotificationDetailsController(Get.find()));
  }
}
