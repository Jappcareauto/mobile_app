import 'package:dartz/dartz.dart';
import 'package:jappcare/features/activities/domain/core/entities/get_all_activities.dart';
import 'package:jappcare/features/activities/domain/core/exceptions/activities_exception.dart';

abstract class ActivitiesRepository {
  //Add methods here

  Future<Either<ActivitiesException, GetAllActivities>> getAllActivities(
      String garageId);
}
