//Don't translate me
import 'package:jappcare/features/chat/domain/core/exceptions/chat_exception.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room.entity.dart';
import 'package:jappcare/features/chat/domain/repositories/chat_repository.dart';

import 'package:dartz/dartz.dart';

class GetAllChatRoomsUseCase {
  final ChatRepository repository;

  GetAllChatRoomsUseCase(this.repository);

  Future<Either<ChatException, GetAllChatRoomsEntity>> call() async {
    return await repository.getAllChatRooms();
  }
}
