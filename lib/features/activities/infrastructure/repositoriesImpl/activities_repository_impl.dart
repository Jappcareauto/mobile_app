//Don't translate me
import 'package:dartz/dartz.dart';
import 'package:jappcare/core/exceptions/base_exception.dart';
import 'package:jappcare/features/activities/domain/core/exceptions/activities_exception.dart';
import 'package:jappcare/features/activities/domain/core/utils/activities_constants.dart';

import '../../domain/repositories/activities_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';
import '../../domain/core/entities/get_all_activities.dart';
import '../models/get_all_activities_model.dart';

class ActivitiesRepositoryImpl implements ActivitiesRepository {
  final NetworkService networkService;

  ActivitiesRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<ActivitiesException, GetAllActivities>> getAllActivities(
      String garageId) async {
    try {
      final response = await networkService.post(
          ActivitiesConstants.getAllActivitiesGetUri,
          body: {'garageId': garageId});
      return Right(GetAllActivitiesModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(ActivitiesException(e.message));
    }
  }

  //Add methods here
}
