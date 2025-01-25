//Don't translate me
import 'send_message_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/repositories/workshop_repository.dart';
import '../../domain/entities/send_message.dart';

class SendMessageUseCase {
  final WorkshopRepository repository;

  SendMessageUseCase(this.repository);

  Future<Either<WorkshopException, SendMessage>> call(SendMessageCommand command) async {
    return await repository.sendMessage(command.senderId,command.content,command.chatRoomId,command.timestamp,command.type,command.appointmentId);  }
}
