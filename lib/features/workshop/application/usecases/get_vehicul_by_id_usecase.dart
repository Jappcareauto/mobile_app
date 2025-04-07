//Don't translate me
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';

import '../command/get_vehicul_by_id_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/repositories/workshop_repository.dart';

class GetVehiculByIdUseCase {
  final WorkshopRepository repository;

  GetVehiculByIdUseCase(this.repository);

  Future<Either<WorkshopException, Vehicle>> call(
      GetVehiculByIdCommand command) async {
    return await repository.getVehiculById(command.id);
  }
}
