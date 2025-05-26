//Don't translate me
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';
import 'package:jappcare/features/workshop/infrastructure/models/get_all_appointments_model.dart';

import '../../domain/repositories/garage_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

import '../../domain/entities/get_garage_by_owner_id.dart';
import '../../../../core/exceptions/base_exception.dart';
import '../../domain/core/exceptions/garage_exception.dart';
import '../../domain/core/utils/garage_constants.dart';
import 'package:dartz/dartz.dart';
import '../models/get_garage_by_owner_id_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/get_vehicle_list.dart';
import '../models/get_vehicle_list_model.dart';

class GarageRepositoryImpl implements GarageRepository {
  final NetworkService networkService;

  GarageRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<GarageException, Vehicle>> addVehicle(
      String garageId, String vin, String registrationNumber) async {
    try {
      final response = await networkService.post(
        GarageConstants.addVehiclePostUri,
        body: {
          // 'name': "Test name",
          'garageId': garageId,
          'vin': vin,
          'registrationNumber': registrationNumber,
          // 'description': "Test description",
          'withMedia': true,
        },
      );
      print(response);
      return Right(VehicleModel.fromJson(response["data"]).toEntity());
    } on BaseException catch (e) {
      return Left(GarageException(e.message));
    }
  }

  @override
  Future<Either<GarageException, List<Vehicle>>> getVehicleList(
      String ownerId) async {
    try {
      final response = await networkService
          .get('${GarageConstants.getVehicleListByOwnerIdGetUri}/$ownerId');
      return Right((response['data'] as List)
          .map((e) => VehicleModel.fromJson(e).toEntity())
          .toList());
    } on BaseException catch (e) {
      return Left(GarageException(e.message));
    }
  }

  @override
  Future<Either<GarageException, List<AppointmentEntity>>> getAllAppointments(
      {String? status}) async {
    try {
      final response = await networkService.post(
          GarageConstants.getAllAppointmentsUri,
          body: {'status': status});
      return Right((response["data"] as List)
          .map((e) => AppointmentModel.fromJson(e).toEntity())
          .toList());
    } on BaseException catch (e) {
      return Left(GarageException(e.message));
    }
  }

  @override
  Future<Either<GarageException, GetGarageByOwnerId>> getGarageByOwnerId(
      String userId) async {
    try {
      final response = await networkService.get(
        "${GarageConstants.getGarageByOwnerIdGetUri}/$userId",
      );
      return Right(
          GetGarageByOwnerIdModel.fromJson((response["data"] as List).first)
              .toEntity());
    } on BaseException catch (e) {
      return Left(GarageException(e.message));
    }
  }

  @override
  Future<Either<GarageException, String>> getPlaceName(
      double latitude, double longitude) async {
    final url = Uri.parse(
        "${GarageConstants.googlePlaceUri}$latitude,$longitude&key=${GarageConstants.apiKey}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          return Right(data['results'][0]
              ['formatted_address']); // Récupère l'adresse formatée
        } else {
          return const Right("Adresse non trouvée");
        }
      } else {
        throw Exception("Erreur API : ${response.statusCode}");
      }
    } catch (e) {
      return Left(GarageException("Erreur : $e"));
    }
  }

  @override
  Future<Either<GarageException, String>> deleteVehicle(String id) async {
    try {
      final response = await networkService.delete(
        "${GarageConstants.addVehiclePostUri}/$id",
      );
      print(response);
      return const Right("Vehicle deleted successfully");
    } on BaseException catch (e) {
      return Left(GarageException(e.message));
    }
  }

  @override
  Future<Either<GarageException, Vehicle>> updateVehicle(
      String id,
      String name,
      String garageId,
      String vin,
      String registrationNumber,
      String? description) async {
    try {
      final response = await networkService.put(
        "${GarageConstants.addVehiclePostUri}/$id",
        body: {
          'name': name,
          'garageId': garageId,
          'vin': vin,
          'registrationNumber': registrationNumber,
          'description': description,
          'withMedia': true,
        },
      );
      return Right(VehicleModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(GarageException(e.message));
    }
  }

  //Add methods here
}
