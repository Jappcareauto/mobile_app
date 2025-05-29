//Don't translate me

import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/repositories/workshop_repository.dart';
import '../../domain/entities/get_all_services.entity.dart';

class GetAllservicesUseCase {
  final WorkshopRepository repository;

  GetAllservicesUseCase(this.repository);

  Future<Either<WorkshopException, GetAllServicesEntity>> call() async {
    return await repository.getAllservices();
  }
}
