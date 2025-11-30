//Don't translate me

import 'package:dartz/dartz.dart';
import 'package:jappcare/features/workshop/domain/entities/geocode_position.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/repositories/workshop_repository.dart';

class GetPlaceLatLngUseCase {
  final WorkshopRepository repository;

  GetPlaceLatLngUseCase(this.repository);

  Future<Either<WorkshopException, GeocodePosition>> call(
      double lat, double lng) async {
    return await repository.getAddressFromLatLng(lat, lng);
  }
}
