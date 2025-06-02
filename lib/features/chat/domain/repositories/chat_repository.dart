import 'package:dartz/dartz.dart';
import 'package:jappcare/features/chat/domain/core/exceptions/chat_exception.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room.entity.dart';

// import '../entities/send_message.dart';
abstract class ChatRepository {
  //Add methods here
  // Future<Either<ChatException, SendMessage>> sendMessage(String senderId, String content, String chatRoomId, String timestamp, String type, String appointmentId);
  // Future<Either<ChatException, List<SendMessage>>> getRealTimeMessages(String chatroom,  String token);
  Future<Either<ChatException, GetAllChatRoomsEntity>> getAllChatRooms();
  Future<Either<ChatException, ChatRoomEntity>> getChatRoomByAppointmentId(
      String appointmentId);
}
