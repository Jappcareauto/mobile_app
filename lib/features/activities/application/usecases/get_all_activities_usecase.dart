//Don't translate me
import 'package:dartz/dartz.dart';
import 'package:jappcare/features/activities/application/command/get_all_activities_command.dart';
import 'package:jappcare/features/activities/domain/core/entities/get_all_activities.dart';
import 'package:jappcare/features/activities/domain/core/exceptions/activities_exception.dart';
import 'package:jappcare/features/activities/domain/repositories/activities_repository.dart';

class GetAllActivitiesUseCase {
  final ActivitiesRepository repository;

  GetAllActivitiesUseCase(this.repository);

  Future<Either<ActivitiesException, GetAllActivities>> call(
      GetAllActivitiesCommand command) async {
    return await repository.getAllActivities(command.garageId);
  }
}
