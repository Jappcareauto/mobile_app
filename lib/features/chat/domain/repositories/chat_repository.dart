import 'package:dartz/dartz.dart';
import 'package:jappcare/features/chat/domain/core/exceptions/chat_exception.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room.entity.dart';
import 'package:jappcare/features/chat/domain/entities/send_message.entity.dart';

// import '../entities/send_message.dart';
abstract class ChatRepository {
  //Add methods here
  Future<Either<ChatException, SendMessageEntity>> sendMessage(
      {required String senderId,
      required String content,
      required String chatRoomId,
      required String timestamp,
      required String type,
      String? appointmentId});
  // Future<Either<ChatException, List<SendMessage>>> getRealTimeMessages(String chatroom,  String token);
  Future<Either<ChatException, GetAllChatRoomsEntity>> getAllChatRooms();
  Future<Either<ChatException, ChatRoomEntity>> getChatRoomByAppointmentId(
      String appointmentId);
}
