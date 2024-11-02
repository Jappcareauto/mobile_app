//Don't translate me
import 'add_vehicle_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/garage_exception.dart';
import '../../domain/repositories/garage_repository.dart';
import '../../domain/entities/add_vehicle.dart';

class AddVehicleUseCase {
  final GarageRepository repository;

  AddVehicleUseCase(this.repository);

  Future<Either<GarageException, AddVehicle>> call(AddVehicleCommand command) async {
    return await repository.addVehicle(command.garageId,command.vin);  }
}
