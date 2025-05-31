//Don't translate me
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/garage_exception.dart';
import '../../domain/repositories/garage_repository.dart';
import '../../domain/entities/get_vehicle_list.dart';

class GetVehicleListUseCase {
  final GarageRepository repository;

  GetVehicleListUseCase(this.repository);

  Future<Either<GarageException, List<Vehicle>>> call() async {
    return await repository.getVehicleList();
  }
}
