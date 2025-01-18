import 'package:dartz/dartz.dart';
import 'package:jappcare/features/emergency/domain/core/exceptions/emergency_exception.dart';
import 'package:jappcare/features/emergency/domain/entities/emergency.dart';


abstract class

EmergencyRepository {
  //Add methods here
  Future<Either<EmergencyException, Emergency>> emergency(
      String serviceCenterId , String vehicleId , String title ,String note , String status  , Location location , String id , String createdAt , String updatedAt , String createdBy , String updatedBy
      );
}