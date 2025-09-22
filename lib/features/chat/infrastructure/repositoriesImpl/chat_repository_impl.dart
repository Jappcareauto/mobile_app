//Don't translate me
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jappcare/core/exceptions/base_exception.dart';

import 'package:jappcare/features/chat/domain/core/exceptions/chat_exception.dart';
import 'package:jappcare/features/chat/domain/core/utils/chat_constants.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room.entity.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room_messages.entity.dart';
import 'package:jappcare/features/chat/domain/entities/send_message.entity.dart';
import 'package:jappcare/features/chat/infrastructure/models/get_all_chatroom_messages.model.dart';
import 'package:jappcare/features/chat/infrastructure/models/get_all_chatrooms.model.dart';
import 'package:jappcare/features/chat/infrastructure/models/send_message.model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// import 'package:jappcare/features/chat/domain/entities/send_message.dart';

import '../../domain/repositories/chat_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

import 'package:web_socket_channel/io.dart';

class ChatRepositoryImpl implements ChatRepository {
  final NetworkService networkService;
  WebSocketChannel? channel;

  ChatRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<ChatException, List<SendMessageEntity>>> getRealTimeMessages(
      String chatroom, String token) async {
    final Uri uri = Uri.parse('${ChatConstants.chatUri}$chatroom');

    try {
      // Crée une connexion WebSocket avec les headers nécessaires
      final webSocket = await WebSocket.connect(
        uri.toString(),
        headers: {'Authorization': 'Bearer $token'},
      );

      // Initialise le canal WebSocket
      channel = IOWebSocketChannel(webSocket);

      // Liste pour stocker les messages reçus
      final List<SendMessageEntity> receivedMessages = [];

      // Écoute les messages en temps réel
      channel!.stream.listen(
        (message) {
          final decodedMessage = jsonDecode(message);
          final chatMessage =
              SendMessageModel.fromJson(decodedMessage).toEntity();

          receivedMessages.add(chatMessage);
          print("Nouveau message reçu : $chatMessage");
        },
        onError: (error) {
          print("Erreur WebSocket : $error");
        },
        onDone: () {
          print("Connexion WebSocket fermée.");
        },
      );

      // Retourne la liste des messages reçus
      return Right(receivedMessages);
    } on SocketException catch (e) {
      print("Erreur réseau : $e");
      return Left(ChatException('Erreur réseau : $e', 400));
    } catch (e) {
      print("Erreur inattendue : $e");
      return Left(ChatException('Erreur inattendue : $e', 500));
    }
  }

  @override
  Future<Either<ChatException, GetAllChatRoomMessagesEntity>>
      getAllChatRoomMessages(String chatroom) async {
    try {
      final response = await networkService
          .get('${ChatConstants.getAllChatRoomMessagesUri}/$chatroom');
      return Right(GetAllChatRoomMessagesModel.fromJson(response).toEntity());

      // // Crée une connexion WebSocket avec les headers nécessaires
      // final webSocket = await WebSocket.connect(
      //   uri.toString(),
      //   headers: {'Authorization': 'Bearer $token'},
      // );

      // // Initialise le canal WebSocket
      // channel = IOWebSocketChannel(webSocket);

      // // Liste pour stocker les messages reçus
      // final List<SendMessageEntity> receivedMessages = [];

      // // Écoute les messages en temps réel
      // channel!.stream.listen(
      //   (message) {
      //     final decodedMessage = jsonDecode(message);
      //     final chatMessage =
      //         SendMessageModel.fromJson(decodedMessage).toEntity();

      //     receivedMessages.add(chatMessage);
      //     print("Nouveau message reçu : $chatMessage");
      //   },
      //   onError: (error) {
      //     print("Erreur WebSocket : $error");
      //   },
      //   onDone: () {
      //     print("Connexion WebSocket fermée.");
      //   },
      // );

      // // Retourne la liste des messages reçus
      // return Right(receivedMessages);
    }
    //  on SocketException catch (e) {
    //   print("Erreur réseau : $e");
    //   return Left(ChatException('Erreur réseau : $e'));
    // }
    on BaseException catch (e) {
      print("Erreur inattendue : $e");
      return Left(
          ChatException('Erreur inattendue : ${e.message}', e.statusCode));
    }
  }

  @override
  Future<Either<ChatException, SendMessageEntity>> sendMessage(
      {required String senderId,
      required String content,
      required String chatRoomId,
      required String timestamp,
      required String type,
      String? appointmentId}) async {
    try {
      final response = await networkService.post(
        ChatConstants.sendMessagePostUri,
        body: {
          'senderId': senderId,
          'content': content,
          'chatRoomId': chatRoomId,
          'timestamp': timestamp,
          'type': type,
          'appointmentId': appointmentId,
        },
      );
      return Right(SendMessageModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(ChatException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<ChatException, GetAllChatRoomsEntity>> getAllChatRooms() async {
    try {
      final response = await networkService.post(
        ChatConstants.getAllChatRoomUri,
        body: {},
      );
      return Right(GetAllChatRoomsModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(ChatException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<ChatException, GetAllChatRoomsEntity>> getAllUserChatRooms(
      String userId) async {
    try {
      final response = await networkService.get(
        '${ChatConstants.getAllUserChatRoomsUri}/$userId',
      );
      return Right(GetAllChatRoomsModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(ChatException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<ChatException, ChatRoomEntity>> getChatRoomByAppointmentId(
      String appointmentId) async {
    try {
      final response = await networkService.get(
        '${ChatConstants.getChatRoomByAppointmentIdUri}/$appointmentId',
      );
      return Right(ChatRoomModel.fromJson(response['data']).toEntity());
    } on BaseException catch (e) {
      return Left(ChatException(e.message, e.statusCode));
    }
  }

  //Add methods here
}
