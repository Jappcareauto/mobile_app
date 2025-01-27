import 'package:dartz/dartz.dart';

import '../core/exceptions/workshop_exception.dart';




import '../entities/get_all_services_center.dart';



import '../entities/book_appointment.dart';



import '../entities/created_rome_chat.dart';



import '../entities/send_message.dart';


abstract class




 WorkshopRepository {
  //Add methods here

  Future<Either<WorkshopException, GetAllServicesCenter>> getAllServicesCenter();

  Future<Either<WorkshopException, BookAppointment>> bookAppointment(String date, String locationType, String note, String serviceId, String vehicleId, String status, String id, String createdBy, String updatedBy, String createdAt, String updatedAt);

  Future<Either<WorkshopException, CreatedRomeChat>> createdRomeChat(String name, List<String> participantUserIds);

  Future<Either<WorkshopException, SendMessage>> sendMessage(String senderId, String content, String chatRoomId, String timestamp, String type, String appointmentId);
  Future<Either<WorkshopException, List<SendMessage>>> getRealTimeMessages(String chatroom,  String token);

}






