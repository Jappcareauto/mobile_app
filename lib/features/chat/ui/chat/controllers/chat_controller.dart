import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'dart:convert';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/core/services/form/form_helper.dart';
// import 'package:jappcare/core/services/localServices/local_storage_service.dart';
// import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/core/utils/functions.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/chat/application/usecases/get_all_user_chatrooms.usecase.dart';
import 'package:jappcare/features/chat/application/usecases/get_real_time_message.usecase.dart';
import 'package:jappcare/features/chat/application/usecases/send_message.usecase.dart';
import 'package:jappcare/features/chat/domain/core/exceptions/chat_exception.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room.entity.dart';
import 'package:jappcare/features/chat/navigation/private/chat_private_routes.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
// import 'package:jappcare/features/workshop/application/usecases/get_real_time_message.dart';
import 'package:jappcare/features/workshop/application/command/get_vehicul_by_id_command.dart';
import 'package:jappcare/features/workshop/application/usecases/get_vehicul_by_id_usecase.dart';
// import 'package:jappcare/features/workshop/domain/core/utils/workshop_constants.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
// import 'package:jappcare/features/workshop/infrastructure/models/send_message_model.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirm_appointment_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// import 'package:web_socket_channel/io.dart';

class ChatController extends GetxController {
  final AppNavigation _appNavigation;

  final ConfirmAppointmentController confirmeAppointmentController =
      ConfirmAppointmentController(Get.find());

  final _getAllChatRoomsUseCase = GetAllUserChatRoomsUseCase(Get.find());

  final loading = false.obs;
  final searchQuery = ''.obs;
  final globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();

  GetVehiculByIdUseCase getVehiculByIdUseCase =
      GetVehiculByIdUseCase(Get.find());
  final selectedMethod = 'Orange Money'.obs;
  ChatController(this._appNavigation);
  late WebSocketChannel channel;
  final ScrollController scrollController = ScrollController();

  final RxList<ChatRoomEntity> chatrooms = <ChatRoomEntity>[].obs;

  var selectedImages = <File>[].obs;
  final TextEditingController messageController = TextEditingController();
  // final LocalStorageService _localStorage = Get.find<LocalStorageService>();
  SendMessageUseCase sendMessageUseCase = SendMessageUseCase(Get.find());
  GetRealTimeMessageUseCase getRealTimeMessageUseCase =
      GetRealTimeMessageUseCase(Get.find());

  late FormHelper messageSearchFormHelper;

  @override
  void onInit() {
    super.onInit();
    fetchChats();
    // globalControllerWorkshop.addData("chatroomId", "123456");
    // final chatroom = globalControllerWorkshop.workshopData['chatroomId'];
    // print('chatroom $chatroom');
    // getrealTimeMessage(chatroom, _localStorage.read(AppConstants.tokenKey));
    messageSearchFormHelper = FormHelper<ChatException, List>(
      fields: {
        "name": null,
      },

      // validators: {
      //   "vin": validateVin,
      //   "registration": Validators.requiredField,
      // },
      // onSubmit: (data) {
      //   return _getAllservicesUseCase.call(AddVehicleCommand(
      //       garageId: Get.find<GarageController>().myGarage!.id,
      //       vin: data['vin']!,
      //       registrationNumber: data['registration']!));
      // },
      onError: (e) => Get.showCustomSnackBar(e.message),
      onSuccess: (response) {
        // Get.find<GarageController>()
        //     .getVehicleList(Get.find<GarageController>().myGarage!.id);
        // _appNavigation.goBack();
      },
    );
  }

  // Filtered chats based on search
  List<ChatRoomEntity> get filteredChats {
    if (searchQuery.value.isEmpty) {
      return chatrooms;
    }
    return chatrooms
        .where((chat) => chat.name
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase())
            // ||
            // chat.lastMessage.toLowerCase().contains(searchQuery.value.toLowerCase()
            // )
            )
        .toList();
  }

  // Fetch chats from service
  Future<void> fetchChats() async {
    loading.value = true;
    final result = await _getAllChatRoomsUseCase
        .call(Get.find<ProfileController>().userInfos!.id);

    result.fold(
      (e) {
        loading.value = false;
        if (Get.context != null) {
          Get.showCustomSnackBar(e.message);
        }
      },
      (response) {
        loading.value = false;
        chatrooms.assignAll(response.data);
      },
    );

    // try {
    //   isLoading(true);
    //   final chatList = await _chatService.fetchChats();
    //   chats.assignAll(chatList);
    // } catch (e) {
    //   Get.snackbar(
    //     'Error',
    //     'Failed to load chats: $e',
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // } finally {
    //   isLoading(false);
    // }
  }

  // Refresh chats
  Future<void> refreshChats() async {
    await fetchChats();
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
  // Future<void> getrealTimeMessage(String chatroom, String token) async {
  //   final Uri uri = Uri.parse('${WorkshopConstants.chatUri}$chatroom');
  //   try {
  //     // Crée une connexion WebSocket avec les headers nécessaires
  //     final webSocket = await WebSocket.connect(
  //       uri.toString(),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );
  //     // Initialise le canal WebSocket
  //     channel = IOWebSocketChannel(webSocket);
  //     // Liste pour stocker les messages reçus

  //     // Écoute les messages en temps réel
  //     channel.stream.listen(
  //       (message) {
  //         final decodedMessage = jsonDecode(message);
  //         final chatMessage =
  //             SendMessageModel.fromJson(decodedMessage).toEntity();
  //         messages.add(chatMessage);
  //         print("Nouveau message reçu : $decodedMessage");
  //       },
  //       onError: (error) {
  //         print("Erreur WebSocket : $error");
  //         _handleReconnection(chatroom, token);
  //         print("REConnexion WebSocket REUSSIE.");
  //       },
  //       onDone: () {
  //         print("Connexion WebSocket fermée.");
  //         _handleReconnection(chatroom, token);
  //         print("REConnexion WebSocket REUSSIE.");
  //       },
  //     );
  //   } on SocketException catch (e) {
  //     print("Erreur réseau : $e");
  //   } catch (e) {
  //     print("Erreur inattendue : $e");
  //   }
  // }

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

  // void _handleReconnection(String chatroom, String token) {
  //   print("Tentative de reconnexion...");
  //   Future.delayed(const Duration(seconds: 5), () {
  //     messages.clear();
  //     getrealTimeMessage(
  //         chatroom, token); // Tente de se reconnecter après 5 secondes
  //   });
  // }

  Future<void> pickImage() async {
    final images = await getImage(many: true);
    if (images != null) {
      selectedImages.addAll(images);
    }
  }

  void goToChat(ChatRoomEntity chatRoom) {
    _appNavigation.toNamed(ChatPrivateRoutes.chat, arguments: chatRoom.id);
    // globalControllerWorkshop.addData('appointmentId', chatRoom.appointmentDTO);
  }

  void goToAppointmentDetail() {
    _appNavigation.toNamed(WorkshopPrivateRoutes.appointmentDetail,
        arguments: globalControllerWorkshop.selectVehicle);
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
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

// import 'dart:async';
// import 'dart:io';
// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:jappcare/core/navigation/app_navigation.dart';
// import 'package:jappcare/core/services/localServices/local_storage_service.dart';
// import 'package:jappcare/core/services/networkServices/dio_network_service.dart';
// import 'package:jappcare/core/utils/app_constants.dart';
// import 'package:jappcare/core/utils/app_images.dart';
// import 'package:jappcare/core/utils/functions.dart';
// import 'package:jappcare/core/utils/getx_extensions.dart';
// import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
// import 'package:jappcare/features/workshop/application/usecases/get_real_time_message.dart';
// import 'package:jappcare/features/workshop/application/usecases/get_real_time_message_command.dart';
// import 'package:jappcare/features/workshop/application/usecases/send_message_command.dart';
// import 'package:jappcare/features/workshop/application/usecases/send_message_usecase.dart';
// import 'package:jappcare/features/workshop/domain/core/utils/workshop_constants.dart';
// import 'package:jappcare/features/workshop/domain/entities/send_message.dart';
// import 'package:jappcare/features/workshop/infrastructure/models/send_message_model.dart';
// import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
// import 'package:jappcare/features/workshop/ui/chat/widgets/payment_method_widget.dart';
// import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
//
// import 'package:web_socket_channel/io.dart';
// import '../../../domain/core/exceptions/workshop_exception.dart';
// class ChatController extends GetxController {
//   final ConfirmeAppointmentController confirmeAppointmentController = ConfirmeAppointmentController(Get.find());
//   final AppNavigation _appNavigation;
//   final selectedMethod = 'Orange Money'.obs ;
//   ChatController(this._appNavigation);
//   late WebSocketChannel channel;
//   final ScrollController scrollController = ScrollController();
//   final RxList<SendMessage> messages = <SendMessage>[].obs;
//   var selectedImages = <File>[].obs;
//   final TextEditingController messageController = TextEditingController();
//   final LocalStorageService _localStorage = Get.find<LocalStorageService>();
//   SendMessageUseCase sendMessageUseCase = SendMessageUseCase(Get.find());
//   GetRealTimeMessageUseCase getRealTimeMessageUseCase = GetRealTimeMessageUseCase(Get.find());
//   @override
//   void onInit() {
//     super.onInit();
//     final chatroom = '5e489f81-67ff-424e-8882-80d9debd9d32';
//     getrealTimeMessage(chatroom , _localStorage.read(AppConstants.tokenKey));
//
//
//   }
//
//   var paymentDetails = [
//     {
//       "name":"MTN Momo",
//       "icon":AppImages.mtnLogo,
//       "numero":"+237691121881"
//     },
//     {
//       "name":"Orange Money",
//       "icon":AppImages.orangeLogo,
//       "numero":"+237691121881"
//     },
//     {
//       "name":"Card",
//       "icon":AppImages.card,
//       "numero":"**** **** **** 7890"
//     },
//     {
//       "name":"Cash",
//       "icon":AppImages.money,
//       "numero":""
//     }
//   ];
//   Future<void> getrealTimeMessage(String chatroom , String token) async {
//     final Uri uri = Uri.parse('${WorkshopConstants.chatUri}$chatroom');
//     try {
//       // Crée une connexion WebSocket avec les headers nécessaires
//       final webSocket = await WebSocket.connect(
//         uri.toString(),
//         headers: {'Authorization': 'Bearer $token'},
//       );
//       // Initialise le canal WebSocket
//       channel = IOWebSocketChannel(webSocket);
//       // Liste pour stocker les messages reçus
//
//       // Écoute les messages en temps réel
//       channel.stream.listen(
//             (message) {
//           final decodedMessage = jsonDecode(message);
//           final chatMessage = SendMessageModel.fromJson(decodedMessage).toEntity();
//           messages.add(chatMessage);
//           print("Nouveau message reçu : $decodedMessage");
//         },
//         onError: (error) {
//           print("Erreur WebSocket : $error");
//           _handleReconnection(chatroom, token);
//           print("REConnexion WebSocket REUSSIE.");
//
//         },
//         onDone: () {
//           print("Connexion WebSocket fermée.");
//           _handleReconnection(chatroom, token);
//           print("REConnexion WebSocket REUSSIE.");
//
//
//         },
//       );
//     } on SocketException catch (e) {
//       print("Erreur réseau : $e");
//     } catch (e) {
//       print("Erreur inattendue : $e");
//
//     }
//   }
//   void _handleReconnection(String chatroom, String token) {
//     print("Tentative de reconnexion...");
//     Future.delayed(Duration(seconds: 5), () {
//       getrealTimeMessage(chatroom, token); // Tente de se reconnecter après 5 secondes
//     });
//   }
//   Future<void> pickImage() async {
//     final images = await getImage(many: true);
//     if (images != null) {
//       selectedImages.addAll(images);
//     }
//   }
//   void removeImage(int index) {
//     selectedImages.removeAt(index);
//   }
//   void sendMessage()  async {
//     if (messageController.text.isNotEmpty || selectedImages.isNotEmpty) {
//       try {
//         // Créer une instance de SendMessage
//         final newMessage = SendMessage.create(
//             senderId:Get.find<ProfileController>().userInfos!.id,
//             content: messageController.text,
//             chatRoomId:Get.arguments['chatroomId'],
//             timestamp: DateTime.now().toIso8601String(),
//             type: selectedImages.isNotEmpty ? "image" : "TEXT_SIMPLE",
//             appointmentId: "63b7abec-83eb-4192-bb3a-e50df522c9c9" // a remplacer lorsque le enpoint de creation des rendez voux seras fonctionnel,
//         );
//         // Ajouter à la liste des messages
//         messages.add(newMessage);
//         // Réinitialiser les champs
//         messageController.clear();
//         selectedImages.clear();
//         // Mettre à jour l'état
//         update();
//         scrollToBottom();
//         //sauvegarder le message dans la base de donneee
//         await insertMessageToDataBase();
//       } catch (e) {
//         print("Erreur lors de l'envoi du message : $e");
//       }
//     }
//   }
//   Future<void> insertMessageToDataBase() async {
//     final result = await sendMessageUseCase.call(SendMessageCommand(
//         appointmentId: "63b7abec-83eb-4192-bb3a-e50df522c9c9" ,// a remplacer lorsque le enpoint de creation des rendez voux seras fonctionnel,
//         chatRoomId: Get.arguments['chatroomId'],
//         content:  messageController.text,
//         type: selectedImages.isNotEmpty ? "image" : "TEXT_SIMPLE",
//         senderId: Get.find<ProfileController>().userInfos!.id,
//         timestamp: DateTime.now().toIso8601String()
//     ));
//     result.fold(
//             (e){
//           print('erreur d\'envoie du message $e');
//           Get.showCustomSnackBar(e.message);
//         },
//             (response){
//           print('message envoyer avec succes');
//           print(response);
//         });
//   }
//
//   void openMore() {
//     showModalBottomSheet(
//       context: Get.context!,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (context) => Placeholder(),
//     );
//   }
//
//   void goBack() {
//     _appNavigation.goBack();
//   }
//   void selectMethode (String methode){
//     selectedMethod.value = methode ;
//   }
//   void goToAddPaymentMethodForm(String? methode){
//     Get.back();
//     if(methode == 'Card'){
//
//       _appNavigation.toNamed(WorkshopPrivateRoutes.payWithCard);
//     }
//     if(methode == 'MTN Momo' || methode== 'Orange Money'){
//       _appNavigation.toNamed(WorkshopPrivateRoutes.payWithPhone);
//     }
//   }
//   void scrollToBottom() {
//     if (scrollController.hasClients) {
//       scrollController.animateTo(
//         scrollController.position.maxScrollExtent,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }
//
//   void onClose() {
//     // Fermer proprement la connexion WebSocket
//     channel.sink.close();
//     super.onClose();
//   }
// }
