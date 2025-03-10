import 'package:dartz/dartz.dart';

import '../core/exceptions/garage_exception.dart';
import '../entities/get_garage_by_owner_id.dart';

import '../entities/get_vehicle_list.dart';

abstract class GarageRepository {
  //Add methods here
  Future<Either<GarageException, GetGarageByOwnerId>> getGarageByOwnerId(
      String userId);

  Future<Either<GarageException, List<Vehicle>>> getVehicleList(
      String garageId);

  Future<Either<GarageException, Vehicle>> addVehicle(
      String garageId, String vin, String registrationNumber);
  Future<Either<GarageException, String>> getPlaceName(
      double longitude, double latitude);
}
