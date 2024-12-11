import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/appointment_details/controllers/appointment_details_controller.dart';

class AppointmentDetailsBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<AppointmentDetailsController>(() => AppointmentDetailsController(Get.find()));
  }
}