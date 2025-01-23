import 'package:dartz/dartz.dart';
import 'package:jappcare/features/emergency/domain/core/exceptions/emergency_exception.dart';
import 'package:jappcare/features/emergency/domain/entities/emergency.dart';


import '../core/exceptions/emergency_exception.dart';
import '../entities/declined_emergency.dart';


abstract class


EmergencyRepository {
  //Add methods here
  Future<Either<EmergencyException, Emergency>> emergency(
      String serviceCenterId , String vehicleId ,
      String title ,String note , String status  ,
      Location location
      );
  Future<Either<EmergencyException, DeclinedEmergency>> declinedEmergency(String id, String status);

}
