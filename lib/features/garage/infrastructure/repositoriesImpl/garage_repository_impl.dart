//Don't translate me
import '../../domain/repositories/garage_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

class GarageRepositoryImpl implements GarageRepository {
  final NetworkService networkService;

  GarageRepositoryImpl({
    required this.networkService,
  });

  //Add methods here

}
