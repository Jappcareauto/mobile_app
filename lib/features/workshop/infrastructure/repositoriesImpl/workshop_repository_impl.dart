//Don't translate me
import '../../domain/repositories/workshop_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

import '../../../../core/exceptions/base_exception.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/core/utils/workshop_constants.dart';
import 'package:dartz/dartz.dart';


import '../../domain/entities/get_all_services_center.dart';
import '../models/get_all_services_center_model.dart';

import '../../domain/entities/book_appointment.dart';
import '../models/book_appointment_model.dart';

class WorkshopRepositoryImpl implements WorkshopRepository {
  final NetworkService networkService;

  WorkshopRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<WorkshopException, BookAppointment>> bookAppointment(String date, String locationType, String note, String serviceId, String vehicleId, String status, String id, String createdBy, String updatedBy, String createdAt, String updatedAt) async {
    try {
      final response = await networkService.post(
        WorkshopConstants.bookAppointmentPostUri,
        body: {'date': date, 'locationType': locationType, 'note': note, 'serviceId': serviceId, 'vehicleId': vehicleId, 'status': status, 'id': id, 'createdBy': createdBy, 'updatedBy': updatedBy, 'createdAt': createdAt, 'updatedAt': updatedAt, },
      );
      return Right(BookAppointmentModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message));
    }
  }


  @override
  Future<Either<WorkshopException, GetAllServicesCenter>> getAllServicesCenter() async {
    try {
      final response = await networkService.get(
        WorkshopConstants.getAllServicesCenterGetUri,
        
      );
      return Right(GetAllServicesCenterModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message));
    }
  }






  //Add methods here

}
