//Don't translate me
import 'package:jappcare/features/garage/application/usecases/update_vehicle_command.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/garage_exception.dart';
import '../../domain/repositories/garage_repository.dart';

class UpdateVehicleUseCase {
  final GarageRepository repository;

  UpdateVehicleUseCase(this.repository);

  Future<Either<GarageException, Vehicle>> call(
      UpdateVehicleCommand command) async {
    return await repository.updateVehicle(
        command.id,
        command.name,
        command.garageId,
        command.vin,
        command.registrationNumber,
        command.description);
  }
}
