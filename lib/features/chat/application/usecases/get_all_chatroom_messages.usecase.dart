// //Don't translate me
import 'package:jappcare/features/chat/application/command/get_all_chatroom_messages.command.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room_messages.entity.dart';
import 'package:jappcare/features/chat/domain/repositories/chat_repository.dart';
import 'package:jappcare/features/chat/domain/core/exceptions/chat_exception.dart';

import 'package:dartz/dartz.dart';

class GetAllChatRoomMessagesUseCase {
  final ChatRepository repository;

  GetAllChatRoomMessagesUseCase(this.repository);

  Future<Either<ChatException, GetAllChatRoomMessagesEntity>> call(
      GetAllChatroomMessagesCommand command) async {
    return await repository.getAllChatRoomMessages(command.chatroom);
  }
}
