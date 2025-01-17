//Don't translate me
import 'package:dartz/dartz.dart';
import 'package:jappcare/core/exceptions/base_exception.dart';
import 'package:jappcare/core/services/networkServices/network_service.dart';
import 'package:jappcare/features/emergency/domain/core/exceptions/emergency_exception.dart';
import 'package:jappcare/features/emergency/domain/core/utils/emergency_constants.dart';
import 'package:jappcare/features/emergency/domain/entities/emergency.dart';
import 'package:jappcare/features/emergency/domain/repositories/emergency_repository.dart';
import 'package:jappcare/features/emergency/infrastructure/models/emergency_model.dart';



class EmergencyRepositoryImpl implements EmergencyRepository {
  final NetworkService networkService;

  EmergencyRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<EmergencyException, Emergency>> emergency(
      String serviceCenterId , String vehicleId , String title ,String note , String status  , Location location , String id , String createdAt , String updatedAt , String createdBy , String updatedBy

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
          'location': location,
          'id': id,
          'createdAt': createdAt,
          'updatedAt': updatedAt,
          'createdBy': createdBy,
          'updatedBy': updatedBy,

        },
      );
      return Right(EmergencyModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(EmergencyException(e.message));
    }
  }


//Add methods here
}
