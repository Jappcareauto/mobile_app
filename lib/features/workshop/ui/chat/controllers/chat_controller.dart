import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/core/utils/functions.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:jappcare/features/workshop/application/usecases/get_real_time_message.dart';
import 'package:jappcare/features/workshop/application/usecases/get_vehicul_by_id_command.dart';
import 'package:jappcare/features/workshop/application/usecases/get_vehicul_by_id_usecase.dart';
import 'package:jappcare/features/workshop/application/usecases/send_message_command.dart';
import 'package:jappcare/features/workshop/application/usecases/send_message_usecase.dart';
import 'package:jappcare/features/workshop/domain/core/utils/workshop_constants.dart';
import 'package:jappcare/features/workshop/domain/entities/send_message.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/infrastructure/models/send_message_model.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:web_socket_channel/io.dart';

class ChatController extends GetxController {
  final ConfirmeAppointmentController confirmeAppointmentController =
      ConfirmeAppointmentController(Get.find());
  final AppNavigation _appNavigation;
  final loading = false.obs;
  final globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();
  GetVehiculByIdUseCase getVehiculByIdUseCase =
      GetVehiculByIdUseCase(Get.find());
  final selectedMethod = 'Orange Money'.obs;
  ChatController(this._appNavigation);
  late WebSocketChannel channel;
  final ScrollController scrollController = ScrollController();
  final RxList<SendMessage> messages = <SendMessage>[].obs;
  var selectedImages = <File>[].obs;
  final TextEditingController messageController = TextEditingController();
  final LocalStorageService _localStorage = Get.find<LocalStorageService>();
  SendMessageUseCase sendMessageUseCase = SendMessageUseCase(Get.find());
  GetRealTimeMessageUseCase getRealTimeMessageUseCase =
      GetRealTimeMessageUseCase(Get.find());
  @override
  void onInit() {
    super.onInit();
    globalControllerWorkshop.addData("chatroomId", "123456");
    final chatroom = globalControllerWorkshop.workshopData['chatroomId'];
    print('chatroom $chatroom');
    getrealTimeMessage(chatroom, _localStorage.read(AppConstants.tokenKey));
  }

  var paymentDetails = [
    {"name": "MTN Momo", "icon": AppImages.mtnLogo, "numero": "+237691121881"},
    {
      "name": "Orange Money",
      "icon": AppImages.orangeLogo,
      "numero": "+237691121881"
    },
    {"name": "Card", "icon": AppImages.card, "numero": "**** **** **** 7890"},
    {"name": "Cash", "icon": AppImages.money, "numero": ""}
  ];
  Future<void> getrealTimeMessage(String chatroom, String token) async {
    final Uri uri = Uri.parse('${WorkshopConstants.chatUri}$chatroom');
    try {
      // Crée une connexion WebSocket avec les headers nécessaires
      final webSocket = await WebSocket.connect(
        uri.toString(),
        headers: {'Authorization': 'Bearer $token'},
      );
      // Initialise le canal WebSocket
      channel = IOWebSocketChannel(webSocket);
      // Liste pour stocker les messages reçus

      // Écoute les messages en temps réel
      channel.stream.listen(
        (message) {
          final decodedMessage = jsonDecode(message);
          final chatMessage =
              SendMessageModel.fromJson(decodedMessage).toEntity();
          messages.add(chatMessage);
          print("Nouveau message reçu : $decodedMessage");
        },
        onError: (error) {
          print("Erreur WebSocket : $error");
          _handleReconnection(chatroom, token);
          print("REConnexion WebSocket REUSSIE.");
        },
        onDone: () {
          print("Connexion WebSocket fermée.");
          _handleReconnection(chatroom, token);
          print("REConnexion WebSocket REUSSIE.");
        },
      );
    } on SocketException catch (e) {
      print("Erreur réseau : $e");
    } catch (e) {
      print("Erreur inattendue : $e");
    }
  }

  Future<void> getVehiculeById() async {
    loading.value = true;
    final result = await getVehiculByIdUseCase.call(GetVehiculByIdCommand(
        id: globalControllerWorkshop.workshopData['vehiculeId']));
    result.fold((e) {
      Get.showCustomSnackBar(e.message);
      print(e.message);
      loading.value = false;
    }, (response) {
      _appNavigation.toNamed(WorkshopPrivateRoutes.appointmentDetail,
          arguments: response);
      loading.value = false;
    });
  }

  void _handleReconnection(String chatroom, String token) {
    print("Tentative de reconnexion...");
    Future.delayed(const Duration(seconds: 5), () {
      messages.clear();
      getrealTimeMessage(
          chatroom, token); // Tente de se reconnecter après 5 secondes
    });
  }

  Future<void> pickImage() async {
    final images = await getImage(many: true);
    if (images != null) {
      selectedImages.addAll(images);
    }
  }

  void goToAppointmentDetail() {
    _appNavigation.toNamed(WorkshopPrivateRoutes.appointmentDetail,
        arguments: globalControllerWorkshop.selectVehicle);
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty || selectedImages.isNotEmpty) {
      try {
        // Créer une instance de SendMessage
        final newMessage = SendMessage.create(
          senderId: Get.find<ProfileController>().userInfos!.id,
          content: messageController.text,
          chatRoomId: globalControllerWorkshop.workshopData['chatroomId'],
          timestamp: DateTime.now().toIso8601String(),
          type: selectedImages.isNotEmpty ? "image" : "TEXT_SIMPLE",
          appointmentId: globalControllerWorkshop.workshopData['appointmentId'],
        );
        // Ajouter à la liste des messages
        messages.add(newMessage);
        await insertMessageToDataBase();
        // Réinitialiser les champs
        messageController.clear();
        selectedImages.clear();
        // Mettre à jour l'état
        update();
        scrollToBottom();
        //sauvegarder le message dans la base de donneee
      } catch (e) {
        print("Erreur lors de l'envoi du message : $e");
      }
    }
  }

  Future<void> insertMessageToDataBase() async {
    final result = await sendMessageUseCase.call(SendMessageCommand(
        appointmentId: globalControllerWorkshop.workshopData[
            'appointmentId'], // a remplacer lorsque le enpoint de creation des rendez voux seras fonctionnel,
        chatRoomId: globalControllerWorkshop.workshopData['chatroomId'],
        content: messageController.text,
        type: selectedImages.isNotEmpty ? "image" : "TEXT_SIMPLE",
        senderId: Get.find<ProfileController>().userInfos!.id,
        timestamp: DateTime.now().toIso8601String()));
    result.fold((e) {
      print('erreur d\'envoie du message $e');
      Get.showCustomSnackBar(e.message);
    }, (response) {
      print('message envoyer avec succes');
      print(response);
    });
  }

  void openMore() {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const Placeholder(),
    );
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void selectMethode(String methode) {
    selectedMethod.value = methode;
  }

  void goToAddPaymentMethodForm(String? methode) {
    Get.back();
    if (methode == 'Card') {
      _appNavigation.toNamed(WorkshopPrivateRoutes.payWithCard);
    }
    if (methode == 'MTN Momo' || methode == 'Orange Money') {
      _appNavigation.toNamed(WorkshopPrivateRoutes.payWithPhone);
    }
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void onClose() {
    // Fermer proprement la connexion WebSocket
    channel.sink.close();
    super.onClose();
  }
}
