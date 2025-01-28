//Don't translate me
import '../../domain/repositories/workshop_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

import '../../../../core/exceptions/base_exception.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/core/utils/workshop_constants.dart';
import 'package:dartz/dartz.dart';


import '../../domain/entities/get_all_services_center.dart';
import '../models/get_all_services_center_model.dart';

import '../../domain/entities/book_appointment.dart';
import '../models/book_appointment_model.dart';

import '../../domain/entities/created_rome_chat.dart';
import '../models/created_rome_chat_model.dart';

import '../../domain/entities/send_message.dart';
import '../models/send_message_model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
class WorkshopRepositoryImpl implements WorkshopRepository {
  final NetworkService networkService;
  WebSocketChannel? channel;
  WorkshopRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<WorkshopException, SendMessage>> sendMessage(String senderId, String content, String chatRoomId, String timestamp, String type, String appointmentId) async {
    try {
      final response = await networkService.post(
        WorkshopConstants.sendMessagePostUri,
        body: {'senderId': senderId, 'content': content, 'chatRoomId': chatRoomId, 'timestamp': timestamp, 'type': type, 'appointmentId': appointmentId, },
      );
      return Right(SendMessageModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message));
    }
  }


  @override
  Future<Either<WorkshopException, CreatedRomeChat>> createdRomeChat(String name, List<String> participantUserIds) async {
    try {
      final response = await networkService.post(
        WorkshopConstants.createdRomeChatPostUri,
        body: {
          'name': name,
          'participantUserIds': participantUserIds, },
      );
      return Right(CreatedRomeChatModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message));
    }
  }


  @override
  Future<Either<WorkshopException, BookAppointment>> bookAppointment(String date, String locationType, String note, String serviceId,  String vehicleId, String status,String timeOfDay ) async {
    try {
      final response = await networkService.post(
        WorkshopConstants.bookAppointmentPostUri,
        body: {'date': date, 'locationType': locationType, 'note': note, 'serviceId': serviceId, 'vehicleId': vehicleId, 'status': status, 'id': id, 'timeOfDay': timeOfDay},
      );
      return Right(BookAppointmentModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message));
    }
  }
  @override
  Future<Either<WorkshopException, List<SendMessage>>> getRealTimeMessages(
      String chatroom, String token) async {
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
      final List<SendMessage> receivedMessages = [];

      // Écoute les messages en temps réel
      channel!.stream.listen(
            (message) {
          final decodedMessage = jsonDecode(message);
          final chatMessage = SendMessageModel.fromJson(decodedMessage).toEntity();

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
      return Left(WorkshopException('Erreur réseau : $e'));
    } catch (e) {
      print("Erreur inattendue : $e");
      return Left(WorkshopException('Erreur inattendue : $e'));
    }
  }



  @override
  Future<Either<WorkshopException, GetAllServicesCenter>> getAllServicesCenter() async {
    try {
      final response = await networkService.get(
        WorkshopConstants.getAllServicesCenterGetUri,
      );
      return Right(GetAllServicesCenterModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message));
    }
  }






  //Add methods here

}
