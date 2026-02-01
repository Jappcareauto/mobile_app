//Don't translate me

import 'package:dartz/dartz.dart';
import 'package:jappcare/features/workshop/application/command/get_service_center_command.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/repositories/workshop_repository.dart';
import '../../domain/entities/get_all_services_center.entity.dart';

class GetAllServicesCenterUseCase {
  final WorkshopRepository repository;

  GetAllServicesCenterUseCase(this.repository);

  Future<Either<WorkshopException, GetAllServiceCenterEntity>> call(
      GetServiceCenterCommand? command) async {
    return await repository.getAllServicesCenter(
        name: command?.name,
        category: command?.category,
        ownerId: command?.ownerId,
        serviceId: command?.serviceId,
        serviceIds: command?.serviceIds,
        serviceCenterId: command?.serviceCenterId,
        aroundMe: command?.aroundMe,
        availableNow: command?.availableNow);
  }
}
