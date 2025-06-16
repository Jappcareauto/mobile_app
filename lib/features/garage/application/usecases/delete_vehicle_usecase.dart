//Don't translate me
import '../command/delete_vehicle_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/garage_exception.dart';
import '../../domain/repositories/garage_repository.dart';

class DeleteVehicleUseCase {
  final GarageRepository repository;

  DeleteVehicleUseCase(this.repository);

  Future<Either<GarageException, String>> call(
      DeleteVehicleCommand command) async {
    return await repository.deleteVehicle(command.id);
  }
}
