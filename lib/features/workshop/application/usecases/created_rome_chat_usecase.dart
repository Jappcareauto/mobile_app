//Don't translate me
import 'created_rome_chat_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/repositories/workshop_repository.dart';
import '../../domain/entities/created_rome_chat.dart';

class CreatedRomeChatUseCase {
  final WorkshopRepository repository;

  CreatedRomeChatUseCase(this.repository);

  Future<Either<WorkshopException, CreatedRomeChat>> call(CreatedRomeChatCommand command) async {
    return await repository.createdRomeChat(command.name,command.participantUserIds) ;  }
}
