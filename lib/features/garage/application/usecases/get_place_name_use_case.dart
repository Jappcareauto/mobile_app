import 'package:jappcare/features/garage/application/command/get_place_name_command.dart';
import 'package:jappcare/features/garage/domain/core/exceptions/garage_exception.dart';
import 'package:jappcare/features/garage/domain/repositories/garage_repository.dart';

import 'package:dartz/dartz.dart';

class GetPlaceNameUseCase {
  GarageRepository repository;
  GetPlaceNameUseCase(this.repository);
  Future<Either<GarageException, String>> call(
      GetPlaceNameCommand command) async {
    return await repository.getPlaceName(command.longitude, command.latitude);
  }
}
