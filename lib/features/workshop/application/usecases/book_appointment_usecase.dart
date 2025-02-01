//Don't translate me
import 'book_appointment_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/repositories/workshop_repository.dart';
import '../../domain/entities/book_appointment.dart';

class BookAppointmentUseCase {
  final WorkshopRepository repository;

  BookAppointmentUseCase(this.repository);

  Future<Either<WorkshopException, BookAppointment>> call(BookAppointmentCommand command) async {
    return await repository.bookAppointment(
        command.date,
        command.locationType,
        command.note,
        command.serviceId,
        command.vehicleId,
        command.status,
        command.timeOfDay
    );
  }
}
