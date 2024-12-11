import 'package:get/get.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';

class ConfirmAppointmentBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<ConfirmeAppointmentController>(() =>ConfirmeAppointmentController(Get.find()));
  }
}