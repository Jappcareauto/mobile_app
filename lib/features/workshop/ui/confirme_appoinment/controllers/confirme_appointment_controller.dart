import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/chat/navigation/chat_public_routes.dart';
import 'package:jappcare/features/home/navigation/home_public_routes.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:jappcare/features/workshop/application/command/book_appointment_command.dart';
import 'package:jappcare/features/workshop/application/usecases/book_appointment_usecase.dart';
// import 'package:jappcare/features/workshop/application/command/created_rome_chat_command.dart';
// import 'package:jappcare/features/workshop/application/usecases/created_rome_chat_usecase.dart';
import 'package:jappcare/features/workshop/domain/core/exceptions/workshop_exception.dart';
import 'package:jappcare/features/workshop/domain/entities/book_appointment.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/widgets/confirm_model.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/widgets/confirmation_appointment_modal.dart';

class ConfirmeAppointmentController extends GetxController {
  final AppNavigation _appNavigation;
  // CreatedRomeChatUseCase createdRomeChatUseCase =
  //     CreatedRomeChatUseCase(Get.find());
  final BookAppointmentUseCase bookAppointmentUseCase =
      BookAppointmentUseCase(Get.find());
  final loading = false.obs;
  final RxList<String> participantId = RxList();
  final proceedChatLoading = false.obs;
  var chatRoomID = ''.obs;
  var appointmentId = ''.obs;
  final requestIsSend = false.obs;
  // final argument = Get.arguments ;
  ConfirmeAppointmentController(this._appNavigation);
  final globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();
  @override
  void onInit() {
    super.onInit();
    participantId.add(Get.find<ProfileController>().userInfos!.id);
  }

  final PageController pageController = PageController();
  void openModal() {
    showModalBottomSheet(
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: Get.context!,
        builder: (BuildContext context) {
          return const ConfirmationAppointmentModal();
        });
  }

  // Future<void> createdRoomChat() async {
  //   proceedChatLoading.value = true;
  //   final result = await createdRomeChatUseCase.call(CreatedRomeChatCommand(
  //       name: globalControllerWorkshop.workshopData['serviceCenterName'],
  //       participantUserIds: participantId));
  //   result.fold((e) {
  //     proceedChatLoading.value = false;
  //     if (Get.context != null) {
  //       Get.showCustomSnackBar(e.message);
  //     }
  //     proceedChatLoading.value = false;
  //   }, (response) {
  //     chatRoomID.value = response.id;
  //     print(response.id);
  //     print(response);
  //     goToChat(response.id);
  //     proceedChatLoading.value = false;
  //   });
  // }

  void goToChat(String chatRoomId) {
    print('got to chat');
    Get.back();
    _appNavigation.toNamed(
      WorkshopPrivateRoutes.processChat,
    );
    globalControllerWorkshop.addMultipleData(
        {'chatroomId': chatRoomId, 'appointmentId': appointmentId.value});
  }

  void goToChatScreen() {
    print('got to chat');
    Get.back();
    _appNavigation.toNamed(
      ChatPublicRoutes.home,
    );
    globalControllerWorkshop
        .addMultipleData({'appointmentId': appointmentId.value});
  }

  void goToHome() {
    Get.back();
    _appNavigation.toNamedAndReplaceAll(
      HomePublicRoutes.home,
    );
    globalControllerWorkshop.resetData();
  }

  Future<Either<WorkshopException, BookAppointment>> booknewAppointment(
      {required DateTime date,
      required String locationType,
      required String note,
      required String serviceId,
      required String vehicleId,
      required String serviceCenterId,
      required String timeOfDay}) async {
    loading.value = true;
    final result = await bookAppointmentUseCase.call(BookAppointmentCommand(
      date: date.toUtc().toIso8601String(),
      locationType: locationType,
      note: note,
      serviceId: serviceId,
      vehicleId: vehicleId,
      timeOfDay: timeOfDay,
      serviceCenterId: serviceCenterId,
      createdBy: Get.find<ProfileController>().userInfos!.id,
    ));
    return result.fold(
      (e) {
        loading.value = false;
        print(e.message);
        Get.showCustomSnackBar("Une erreur s'est produite");
        return Left(WorkshopException(e.message));
      },
      (response) {
        loading.value = false;
        appointmentId.value = response.id;
        onpenModalConfirmMethod();
        print(response);
        return Right(response);
      },
    );
  }

  void onpenModalConfirmMethod() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true, // Permet un contrôle précis sur la hauteur
      backgroundColor: Colors.transparent, // Rendre l'arrière-plan transparent
      builder: (BuildContext context) {
        return const ConfirmModal();
      },
    );
  }
}
