//Don't translate me
import 'emergency_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/emergency_exception.dart';
import '../../domain/repositories/emergency_repository.dart';
import '../../domain/entities/emergency.dart';

class EmergencyUseCase {
  final EmergencyRepository repository;

  EmergencyUseCase(this.repository);

  Future<Either<EmergencyException, Emergency>> call(EmergencyCommand command) async {
    return await repository.emergency(
        command.serviceCenterId,
        command.vehicleId,
        command.title,
        command.note,
        command.status,
        command.location,
        command.id,
        command.createdAt,
        command.updatedAt,
        command.createdBy,
        command.updatedBy
    );  }
}
