//Don't translate me
import 'package:dartz/dartz.dart';
import 'package:jappcare/core/exceptions/base_exception.dart';

import 'package:jappcare/features/chat/domain/core/exceptions/chat_exception.dart';
import 'package:jappcare/features/chat/domain/core/utils/chat_constants.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room.entity.dart';
import 'package:jappcare/features/chat/infrastructure/models/get_all_chatrooms.model.dart';

// import 'package:jappcare/features/chat/domain/entities/send_message.dart';

import '../../domain/repositories/chat_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

class ChatRepositoryImpl implements ChatRepository {
  final NetworkService networkService;

  ChatRepositoryImpl({
    required this.networkService,
  });

  // @override
  // Future<Either<ChatException, List<SendMessage>>> getRealTimeMessages(String chatroom, String token) {
  //   final Uri uri = Uri.parse('${ChatConstants.chatUri}$chatroom');

  //   try {
  //     // Crée une connexion WebSocket avec les headers nécessaires
  //     final webSocket = await WebSocket.connect(
  //       uri.toString(),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );

  //     // Initialise le canal WebSocket
  //     channel = IOWebSocketChannel(webSocket);

  //     // Liste pour stocker les messages reçus
  //     final List<SendMessage> receivedMessages = [];

  //     // Écoute les messages en temps réel
  //     channel!.stream.listen(
  //           (message) {
  //         final decodedMessage = jsonDecode(message);
  //         final chatMessage = SendMessageModel.fromJson(decodedMessage).toEntity();

  //         receivedMessages.add(chatMessage);
  //         print("Nouveau message reçu : $chatMessage");
  //       },
  //       onError: (error) {
  //         print("Erreur WebSocket : $error");
  //       },
  //       onDone: () {
  //         print("Connexion WebSocket fermée.");
  //       },
  //     );

  //     // Retourne la liste des messages reçus
  //     return Right(receivedMessages);
  //   } on SocketException catch (e) {
  //     print("Erreur réseau : $e");
  //     return Left(ChatException('Erreur réseau : $e'));
  //   } catch (e) {
  //     print("Erreur inattendue : $e");
  //     return Left(ChatException('Erreur inattendue : $e'));
  //   }
  // }

  // @override
  // Future<Either<ChatException, SendMessage>> sendMessage(String senderId, String content, String chatRoomId, String timestamp, String type, String appointmentId) {
  //   try {
  //     final response = await networkService.post(
  //       ChatConstants.sendMessagePostUri,
  //       body: {'senderId': senderId, 'content': content, 'chatRoomId': chatRoomId, 'timestamp': timestamp, 'type': type, 'appointmentId': appointmentId, },
  //     );
  //     return Right(SendMessageModel.fromJson(response).toEntity());
  //   } on BaseException catch (e) {
  //     return Left(ChatException(e.message));
  //   }
  // }

  @override
  Future<Either<ChatException, GetAllChatRoomsEntity>> getAllChatRooms() async {
    try {
      final response = await networkService.post(
        ChatConstants.getAllChatRoomUri,
        body: {},
      );
      return Right(GetAllChatRoomsModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(ChatException(e.message));
    }
  }

  @override
  Future<Either<ChatException, ChatRoomEntity>> getChatRoomByAppointmentId(
      String appointmentId) async {
    try {
      final response = await networkService.post(
        ChatConstants.getAllChatRoomUri,
        body: {},
      );
      return Right(ChatRoomModel.fromJson(response['data']).toEntity());
    } on BaseException catch (e) {
      return Left(ChatException(e.message));
    }
  }

  //Add methods here
}
