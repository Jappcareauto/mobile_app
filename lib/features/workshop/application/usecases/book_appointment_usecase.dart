//Don't translate me
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';

import '../command/book_appointment_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/repositories/workshop_repository.dart';
// import '../../domain/entities/book_appointment.dart';

class BookAppointmentUseCase {
  final WorkshopRepository repository;

  BookAppointmentUseCase(this.repository);

  Future<Either<WorkshopException, AppointmentEntity>> call(
      BookAppointmentCommand command) async {
    return await repository.bookAppointment(
        date: command.date,
        locationType: command.locationType,
        location: command.location,
        note: command.note,
        serviceId: command.serviceId,
        vehicleId: command.vehicleId,
        serviceCenterId: command.serviceCenterId,
        createdBy: command.createdBy,
        timeOfDay: command.timeOfDay,
        selectedTimeRange: command.selectedTimeRange);
  }
}
