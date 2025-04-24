//Don't translate me
import 'package:jappcare/features/garage/domain/core/exceptions/garage_exception.dart';
import 'package:jappcare/features/garage/domain/repositories/garage_repository.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';

import 'package:dartz/dartz.dart';

class GetAllAppointmentsUsecase {
  final GarageRepository repository;

  GetAllAppointmentsUsecase(this.repository);

  Future<Either<GarageException, List<AppointmentEntity>>> call(
      {String? status}) {
    return repository.getAllAppointments(status: status);
  }
}
