import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';

class SuccessPaymentController extends GetxController{
  final AppNavigation  _appNavigation ;
  SuccessPaymentController(this._appNavigation);

  void goToAppointmentDetails(){
    _appNavigation.toNamed(WorkshopPrivateRoutes.appointmentDetail);
  }
}