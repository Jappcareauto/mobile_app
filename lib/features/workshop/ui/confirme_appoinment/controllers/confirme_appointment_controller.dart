import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/services/networkServices/dio_network_service.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:jappcare/features/workshop/application/usecases/book_appointment_command.dart';
import 'package:jappcare/features/workshop/application/usecases/book_appointment_usecase.dart';
import 'package:jappcare/features/workshop/application/usecases/created_rome_chat_command.dart';
import 'package:jappcare/features/workshop/application/usecases/created_rome_chat_usecase.dart';
import 'package:jappcare/features/workshop/domain/core/exceptions/workshop_exception.dart';
import 'package:jappcare/features/workshop/domain/entities/book_appointment.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/widgets/confirmation_appointment_modal.dart';

class ConfirmeAppointmentController extends GetxController {
  final AppNavigation _appNavigation;
  CreatedRomeChatUseCase createdRomeChatUseCase = CreatedRomeChatUseCase(Get.find());
  final BookAppointmentUseCase bookAppointmentUseCase = Get.find();
  final loading = false.obs;
  final RxList<String> participantId  = RxList();
  final proceedChatLoading = false.obs ;
  var chatRoomID = ''.obs;
  final requestIsSend = false.obs ;
  // final argument = Get.arguments ;
  ConfirmeAppointmentController(this._appNavigation);

  void onInit() {
    super.onInit();
    participantId.add(Get.find<ProfileController>().userInfos!.id);
  }

  void openModal() {
    showModalBottomSheet(
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: Get.context!,
        builder: (BuildContext context) {
          return ConfirmationAppointmentModal();
        });
  }


  Future<void> createdRoomChat() async{
    proceedChatLoading.value = true;
    final result = await createdRomeChatUseCase.call(CreatedRomeChatCommand(
        name: "APPOINTMENT CHAT",
        participantUserIds: participantId
    ));
    result.fold(
            (e){
              proceedChatLoading.value = false;
              if(Get.context !=null)
                Get.showCustomSnackBar(e.message);
            },
            (response){
              chatRoomID.value = response.id ;
              print(response.id);
              print(response);
              goToChat(response.id);
    });
  }
  void goToChat(String chatRoomId) {
    print('got to chat');
    Get.back();
    _appNavigation.toNamed(WorkshopPrivateRoutes.processChat,
        arguments: {"serviceName": Get.arguments["servicesName"] , "chatroomId":chatRoomId}
    );
  }
  Future<Either<WorkshopException , BookAppointment>> booknewAppointment(String id,
      String locationType, String note, String serviceId, String vehicleId,
      String status,DateTime date,) async {
    loading.value = true ;
    final result = await bookAppointmentUseCase.call(BookAppointmentCommand(
        id: id,
        locationType: locationType,
        note: note,
        serviceId: serviceId,
        vehicleId: vehicleId,
        status: status,
        createdAt: DateTime.now().toUtc().toIso8601String(),
        updatedAt: DateTime.now().toUtc().toIso8601String(),
        createdBy: id,
        date: date.toUtc().toIso8601String(),
        updatedBy: id
    ));
    return result.fold(
          (e) {
        loading.value = false;
        print("erreur.vehicleId");
        print(e.message);
        Get.showCustomSnackBar("Une erreur s'est produite");
        return Left(WorkshopException(e.message));
      },
          (response) {
        loading.value = false;
        print("response.vehicleId");
        requestIsSend.value = true ;
        print(response.vehicleId);

        return Right(response);
      },
    );
  }
}