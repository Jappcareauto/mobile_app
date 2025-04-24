import 'package:dartz/dartz.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:jappcare/features/workshop/domain/entities/place_details.dart';
import 'package:jappcare/features/workshop/domain/entities/place_prediction.dart';

import '../core/exceptions/workshop_exception.dart';

import '../entities/get_all_services_center.dart';

import '../entities/book_appointment.dart';

import '../entities/created_rome_chat.dart';

import '../entities/send_message.dart';

import '../entities/get_all_services.dart';

abstract class WorkshopRepository {
  //Add methods here

  Future<Either<WorkshopException, GetAllServicesCenter>> getAllServicesCenter(
      {String? name,
      String? category,
      String? ownerId,
      String? serviceId,
      String? serviceCenterId,
      bool? aroundMe,
      bool? availableNow});

  Future<Either<WorkshopException, BookAppointment>> bookAppointment(
      String date,
      String locationType,
      String note,
      String serviceId,
      String vehicleId,
      String status,
      String timeOfDay);

  Future<Either<WorkshopException, CreatedRomeChat>> createdRomeChat(
      String name, List<String> participantUserIds);

  Future<Either<WorkshopException, SendMessage>> sendMessage(
      String senderId,
      String content,
      String chatRoomId,
      String timestamp,
      String type,
      String appointmentId);
  Future<Either<WorkshopException, List<SendMessage>>> getRealTimeMessages(
      String chatroom, String token);

  Future<Either<WorkshopException, GetAllservices>> getAllservices();

  Future<Either<WorkshopException, Vehicle>> getVehiculById(String id);

  Future<Either<WorkshopException, List<PlacePrediction>>> fetchAutocomplete(
      String input);
  Future<Either<WorkshopException, PlaceDetails>> fetchPlaceDetails(
      String placeId);
}
