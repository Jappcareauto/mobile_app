import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/widgets/confirmation_appointment_modal.dart';

class ConfirmeAppointmentController extends GetxController{
  final AppNavigation _appNavigation ;

   ConfirmeAppointmentController(this._appNavigation);
    void onInit() {
      super.onInit();
  }
  void openModal() {
    showModalBottomSheet(
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: Get.context!,
        builder: (BuildContext context) {
          return  ConfirmationAppointmentModal();
        });
  }
  void goToChat(){
      print('got to chat');
      _appNavigation.toNamed(WorkshopPrivateRoutes.processChat);
  }
}