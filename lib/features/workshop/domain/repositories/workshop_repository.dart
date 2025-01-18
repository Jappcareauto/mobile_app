import 'package:dartz/dartz.dart';

import '../core/exceptions/workshop_exception.dart';




import '../entities/get_all_services_center.dart';



import '../entities/book_appointment.dart';


abstract class


 WorkshopRepository {
  //Add methods here

  Future<Either<WorkshopException, GetAllServicesCenter>> getAllServicesCenter();

  Future<Either<WorkshopException, BookAppointment>> bookAppointment(String date, String locationType, String note, String serviceId, String vehicleId, String status, String id, String createdBy, String updatedBy, String createdAt, String updatedAt);

}




