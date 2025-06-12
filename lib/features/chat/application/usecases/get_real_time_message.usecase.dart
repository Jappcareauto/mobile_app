// //Don't translate me
import 'package:jappcare/features/chat/application/command/get_real_time_message.command.dart';
import 'package:jappcare/features/chat/domain/entities/send_message.entity.dart';
import 'package:jappcare/features/chat/domain/repositories/chat_repository.dart';
import 'package:jappcare/features/chat/domain/core/exceptions/chat_exception.dart';

import 'package:dartz/dartz.dart';

class GetRealTimeMessageUseCase {
  final ChatRepository repository;

  GetRealTimeMessageUseCase(this.repository);

  Future<Either<ChatException, List<SendMessageEntity>>> call(
      GetRealTimeMessageCommand command) async {
    return await repository.getRealTimeMessages(
        command.chatroom, command.token);
  }
}
