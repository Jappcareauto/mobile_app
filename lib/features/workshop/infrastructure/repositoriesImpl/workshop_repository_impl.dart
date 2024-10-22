//Don't translate me
import '../../domain/repositories/workshop_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

class WorkshopRepositoryImpl implements WorkshopRepository {
  final NetworkService networkService;

  WorkshopRepositoryImpl({
    required this.networkService,
  });

  //Add methods here

}
