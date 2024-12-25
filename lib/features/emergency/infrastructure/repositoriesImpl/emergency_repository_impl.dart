//Don't translate me
import '../../domain/repositories/emergency_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

class EmergencyRepositoryImpl implements EmergencyRepository {
  final NetworkService networkService;

  EmergencyRepositoryImpl({
    required this.networkService,
  });

  //Add methods here

}
