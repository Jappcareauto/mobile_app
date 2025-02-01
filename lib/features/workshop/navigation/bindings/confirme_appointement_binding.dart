import 'package:get/get.dart';
import 'package:jappcare/features/workshop/application/usecases/book_appointment_usecase.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';

class ConfirmAppointmentBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(()=>BookAppointmentUseCase(Get.find()));
    Get.lazyPut<ConfirmeAppointmentController>(() =>ConfirmeAppointmentController(Get.find()));
  }
}