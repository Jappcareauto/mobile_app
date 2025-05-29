//Don't translate me
import 'package:jappcare/features/workshop/application/command/get_service_center_services.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_service_center_services.entity.dart';

import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/repositories/workshop_repository.dart';

class GetServiceCenterServicesUsecase {
  final WorkshopRepository repository;

  GetServiceCenterServicesUsecase(this.repository);

  Future<Either<WorkshopException, GetAllServiceCenterServicesEntity>> call(
      GetServiceCenterServicesCommand command) async {
    return await repository
        .getAllServicesCenterServices(command.serviceCenterId);
  }
}
