//Don't translate me
import '../../domain/repositories/activities_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

class ActivitiesRepositoryImpl implements ActivitiesRepository {
  final NetworkService networkService;

  ActivitiesRepositoryImpl({
    required this.networkService,
  });

  //Add methods here

}
