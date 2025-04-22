//Don't translate me
import 'package:dio/dio.dart';
import 'package:jappcare/features/garage/domain/core/utils/garage_constants.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:jappcare/features/garage/infrastructure/models/get_vehicle_list_model.dart';
import 'package:jappcare/features/workshop/domain/entities/place_details.dart';
import 'package:jappcare/features/workshop/infrastructure/models/place_prediction_model.dart';
import 'package:jappcare/features/workshop/infrastructure/models/place_details_model.dart';
import 'package:jappcare/features/workshop/domain/entities/place_prediction.dart';

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
import '../../domain/entities/get_all_services.dart';
import '../models/get_all_services_model.dart';

class WorkshopRepositoryImpl implements WorkshopRepository {
  final NetworkService networkService;
  WebSocketChannel? channel;
  WorkshopRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<WorkshopException, Vehicle>> getVehiculById(
      String userId) async {
    try {
      final response = await networkService.get(
        "${WorkshopConstants.getVehiculByIdGetUri}/$userId",
      );
      return Right(VehicleModel.fromJson(response["data"]).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message));
    }
  }

  @override
  Future<Either<WorkshopException, GetAllservices>> getAllservices() async {
    try {
      final response = await networkService
          .post(WorkshopConstants.getAllservicesGetUri, body: {});
      return Right(GetAllservicesModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message));
    }
  }

  @override
  Future<Either<WorkshopException, SendMessage>> sendMessage(
      String senderId,
      String content,
      String chatRoomId,
      String timestamp,
      String type,
      String appointmentId) async {
    try {
      final response = await networkService.post(
        WorkshopConstants.sendMessagePostUri,
        body: {
          'senderId': senderId,
          'content': content,
          'chatRoomId': chatRoomId,
          'timestamp': timestamp,
          'type': type,
          'appointmentId': appointmentId,
        },
      );
      return Right(SendMessageModel.fromJson(response["data"]).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message));
    }
  }

  @override
  Future<Either<WorkshopException, CreatedRomeChat>> createdRomeChat(
      String name, List<String> participantUserIds) async {
    try {
      final response = await networkService.post(
        WorkshopConstants.createdRomeChatPostUri,
        body: {
          'name': name,
          'participantUserIds': participantUserIds,
        },
      );
      return Right(CreatedRomeChatModel.fromJson(response["data"]).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message));
    }
  }

  @override
  Future<Either<WorkshopException, BookAppointment>> bookAppointment(
      String date,
      String locationType,
      String note,
      String serviceId,
      String vehicleId,
      String status,
      String timeOfDay) async {
    try {
      final response = await networkService.post(
        WorkshopConstants.bookAppointmentPostUri,
        body: {
          'date': date,
          'locationType': locationType,
          'note': note,
          'serviceId': serviceId,
          'vehicleId': vehicleId,
          'status': status,
          'timeOfDay': timeOfDay,
        },
      );
      return Right(BookAppointmentModel.fromJson(response["data"]).toEntity());
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
      return Left(WorkshopException('Erreur réseau : $e'));
    } catch (e) {
      print("Erreur inattendue : $e");
      return Left(WorkshopException('Erreur inattendue : $e'));
    }
  }

  @override
  Future<Either<WorkshopException, GetAllServicesCenter>> getAllServicesCenter(
      String? name,
      String? category,
      String? ownerId,
      String? serviceCenterId,
      bool? aroundMe,
      bool? availableNow) async {
    try {
      final response = await networkService
          .post(WorkshopConstants.getAllServicesCenterGetUri, body: {
        'name': name,
        'category': category,
        'ownerId': ownerId,
        'serviceCenterId': serviceCenterId,
        'aroundMe': aroundMe,
        'availableNow': availableNow
      });
      return Right(GetAllServicesCenterModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message));
    }
  }

  // 1. Autocomplete → gets a list of { description, place_id }
  @override
  Future<Either<WorkshopException, List<PlacePrediction>>> fetchAutocomplete(
      String input) async {
    final Dio dio = Dio();

    try {
      final k = GarageConstants.apiKey;
      final response =
          await dio.post(WorkshopConstants.googleAutocompleteUri, data: {
        'input': input,
        'key': k,
        'components': 'country:us',
      });
      return Right((response.data['predictions'] as List)
          .map((p) => PlacePredictionModel.fromJson(p).toEntity())
          .toList());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message));
    }
  }

  // 1. Autocomplete → gets a list of { description, place_id }
  @override
  Future<Either<WorkshopException, PlaceDetails>> fetchPlaceDetails(
      String placeId) async {
    final Dio dio = Dio();

    try {
      final k = GarageConstants.apiKey;
      final response =
          await dio.post(WorkshopConstants.googlePlaceDetailsUri, data: {
        'place_id': placeId,
        'key': k,
        'fields': 'formatted_address,geometry',
      });
      return Right(
          PlaceDetailsModel.fromJson(response.data['result']).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message));
    }
  }

  //Add methods here
}
