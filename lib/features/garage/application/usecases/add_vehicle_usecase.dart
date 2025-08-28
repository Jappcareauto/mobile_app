//Don't translate me
import '../../domain/entities/get_vehicle_list.dart';
import '../command/add_vehicle_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/garage_exception.dart';
import '../../domain/repositories/garage_repository.dart';

class AddVehicleUseCase {
  final GarageRepository repository;

  AddVehicleUseCase(this.repository);

  Future<Either<GarageException, Vehicle>> call(
      AddVehicleCommand command) async {
    return await repository.addVehicle(
        command.userId, command.vin, command.registrationNumber);
  }
}
