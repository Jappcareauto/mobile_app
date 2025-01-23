import 'package:dartz/dartz.dart';
import 'package:jappcare/features/emergency/application/usecases/declined_emergency_command.dart';
import 'package:jappcare/features/emergency/domain/core/exceptions/emergency_exception.dart';
import 'package:jappcare/features/emergency/domain/entities/declined_emergency.dart';
import 'package:jappcare/features/emergency/domain/repositories/emergency_repository.dart';

class DeclinedEmergencyUsecase {
  final EmergencyRepository repository ;
  DeclinedEmergencyUsecase(this.repository);
  Future<Either<EmergencyException , DeclinedEmergency>> call  (DeclinedEmergencyCommand command) async{
    return await repository.declinedEmergency(
    command.id,
    command.status
    );
  }
}