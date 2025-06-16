import 'package:dartz/dartz.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';

import '../core/exceptions/garage_exception.dart';
import '../entities/get_garage_by_owner_id.dart';

import '../entities/get_vehicle_list.dart';

abstract class GarageRepository {
  //Add methods here
  Future<Either<GarageException, GetGarageByOwnerId>> getGarageByOwnerId(
      String userId);

  Future<Either<GarageException, List<Vehicle>>> getVehicleList();

  Future<Either<GarageException, List<Vehicle>>> getVehicleListByOwnerId(
      String ownerId);

  Future<Either<GarageException, Vehicle>> getVehicleById(String id);

  Future<Either<GarageException, Vehicle>> addVehicle(
      String serviceCenterId, String vin, String registrationNumber);

  Future<Either<GarageException, String>> getPlaceName(
      double longitude, double latitude);

  Future<Either<GarageException, Vehicle>> updateVehicle(
      String id,
      String name,
      String garageId,
      String vin,
      String registrationNumber,
      String? description);

  Future<Either<GarageException, String>> deleteVehicle(String id);

  Future<Either<GarageException, List<AppointmentEntity>>> getAllAppointments(
      {String? status});

  Future<Either<GarageException, AppointmentEntity>> getAppointmentByChatroomId(
      {required String chatroomId});
}
