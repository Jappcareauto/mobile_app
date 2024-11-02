//Don't translate me
import 'get_garage_by_owner_id_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/garage_exception.dart';
import '../../domain/repositories/garage_repository.dart';
import '../../domain/entities/get_garage_by_owner_id.dart';

class GetGarageByOwnerIdUseCase {
  final GarageRepository repository;

  GetGarageByOwnerIdUseCase(this.repository);

  Future<Either<GarageException, GetGarageByOwnerId>> call(GetGarageByOwnerIdCommand command) async {
    return await repository.getGarageByOwnerId(command.userId);  }
}
