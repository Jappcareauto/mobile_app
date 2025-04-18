//Don't translate me
import 'package:jappcare/features/workshop/domain/entities/place_prediction.dart';

import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/repositories/workshop_repository.dart';

class GetPlaceAutocompleteUsecase {
  final WorkshopRepository repository;

  GetPlaceAutocompleteUsecase(this.repository);

  Future<Either<WorkshopException, List<PlacePrediction>>> call(
      String input) async {
    return await repository.fetchAutocomplete(input);
  }
}
