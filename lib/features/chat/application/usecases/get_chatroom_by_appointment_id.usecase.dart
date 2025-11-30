//Don't translate me
import 'package:jappcare/features/chat/application/command/get_chatroom_by_appointment_id.command.dart';
import 'package:jappcare/features/chat/domain/core/exceptions/chat_exception.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room.entity.dart';
import 'package:jappcare/features/chat/domain/repositories/chat_repository.dart';

import 'package:dartz/dartz.dart';

class GetChatRoomByAppointmentIdUseCase {
  final ChatRepository repository;

  GetChatRoomByAppointmentIdUseCase(this.repository);

  Future<Either<ChatException, ChatRoomEntity>> call(
      GetChatroomByAppointmentIdCommand command) async {
    return await repository.getChatRoomByAppointmentId(command.appointmentId);
  }
}
