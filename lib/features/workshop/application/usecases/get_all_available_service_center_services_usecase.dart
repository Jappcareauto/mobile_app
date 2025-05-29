//Don't translate me
import 'package:jappcare/features/workshop/application/command/get_service_center_services.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_service_center_services.entity.dart';

import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/repositories/workshop_repository.dart';

class GetAllAvailableServiceCenterServicesUsecase {
  final WorkshopRepository repository;

  GetAllAvailableServiceCenterServicesUsecase(this.repository);

  Future<Either<WorkshopException, GetAllServiceCenterServicesEntity>> call(
      GetServiceCenterServicesCommand command) async {
    return await repository
        .getAllAvailableServicesCenterServices(command.serviceCenterId);
  }
}
