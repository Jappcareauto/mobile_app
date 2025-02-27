//Don't translate me
import 'package:dartz/dartz.dart';
import 'package:jappcare/core/exceptions/base_exception.dart';
import 'package:jappcare/core/services/networkServices/network_service.dart';
import 'package:jappcare/features/emergency/domain/core/exceptions/emergency_exception.dart';
import 'package:jappcare/features/emergency/domain/core/utils/emergency_constants.dart';
import 'package:jappcare/features/emergency/domain/entities/emergency.dart';
import 'package:jappcare/features/emergency/domain/repositories/emergency_repository.dart';
import 'package:jappcare/features/emergency/infrastructure/models/emergency_model.dart';



import '../../domain/entities/declined_emergency.dart';
import '../models/declined_emergency_model.dart';

class EmergencyRepositoryImpl implements EmergencyRepository {
  final NetworkService networkService;

  EmergencyRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<EmergencyException, DeclinedEmergency>> declinedEmergency(String id, String status) async {
    try {
      final response = await networkService.patch(
        "${EmergencyConstants.declinedEmergencyPatchUri}/$id/status",
        body: {'status': status, },
      );
      return Right(DeclinedEmergencyModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(EmergencyException(e.message));
    }
  }


  @override
  Future<Either<EmergencyException, Emergency>> emergency(
      String serviceCenterId , String vehicleId , String title ,String note , String status  ,
      Location location

      ) async {
    try {
      final response = await networkService.post(
        EmergencyConstants.emergencyPostUri,
        body: {
          'serviceCenterId': serviceCenterId,
          'vehicleId': vehicleId,
          'title': title,
          'note': note,
          'status': status,
          'location': location.toJson(),
        },
      );
      return Right(EmergencyModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      print("error from repositorie");

      print(e);
      return Left(EmergencyException(e.message));
    }
  }


//Add methods here
}
