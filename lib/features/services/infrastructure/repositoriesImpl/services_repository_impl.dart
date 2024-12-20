//Don't translate me
import '../../domain/repositories/services_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  final NetworkService networkService;

  ServicesRepositoryImpl({
    required this.networkService,
  });

  //Add methods here

}
