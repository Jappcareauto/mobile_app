import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/book_appointment_controller.dart';
import 'package:jappcare/features/workshop/ui/book_appointment/controllers/map_controller.dart';

class BookAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookAppointmentController>(
        () => BookAppointmentController(Get.find()));
    Get.lazyPut<MapController>(() => MapController(Get.find()));
  }
}
