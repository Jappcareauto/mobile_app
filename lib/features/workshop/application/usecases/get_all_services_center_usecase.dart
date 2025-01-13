//Don't translate me

import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/repositories/workshop_repository.dart';
import '../../domain/entities/get_all_services_center.dart';

class GetAllServicesCenterUseCase {
  final WorkshopRepository repository;

  GetAllServicesCenterUseCase(this.repository);

  Future<Either<WorkshopException, GetAllServicesCenter>> call() async {
    return await repository.getAllServicesCenter();  }
}
