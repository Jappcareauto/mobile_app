//Don't translate me
import 'package:jappcare/features/garage/domain/core/exceptions/garage_exception.dart';
import 'package:jappcare/features/garage/domain/repositories/garage_repository.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';

import 'package:dartz/dartz.dart';

class GetAppointmentByChatRoomIdUseCase {
  final GarageRepository repository;

  GetAppointmentByChatRoomIdUseCase(this.repository);

  Future<Either<GarageException, AppointmentEntity>> call(
      {required String chatroomId}) {
    return repository.getAppointmentByChatroomId(chatroomId: chatroomId);
  }
}
