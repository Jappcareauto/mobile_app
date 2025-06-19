//Don't translate me
import 'package:jappcare/features/chat/application/command/send_message.command.dart';
import 'package:jappcare/features/chat/domain/core/exceptions/chat_exception.dart';
import 'package:jappcare/features/chat/domain/entities/send_message.entity.dart';
import 'package:jappcare/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<Either<ChatException, SendMessageEntity>> call(
      SendMessageCommand command) async {
    return await repository.sendMessage(
        senderId: command.senderId,
        content: command.content,
        chatRoomId: command.chatRoomId,
        timestamp: command.timestamp,
        type: command.type,
        appointmentId: command.appointmentId);
  }
}
