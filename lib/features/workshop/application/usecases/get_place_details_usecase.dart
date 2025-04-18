//Don't translate me
import 'package:jappcare/features/workshop/domain/entities/place_details.dart';

import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/repositories/workshop_repository.dart';

class GetPlaceDetailsUseCase {
  final WorkshopRepository repository;

  GetPlaceDetailsUseCase(this.repository);

  Future<Either<WorkshopException, PlaceDetails>> call(String placeId) async {
    return await repository.fetchPlaceDetails(placeId);
  }
}
