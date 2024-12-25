//Don't translate me
import '../../domain/repositories/vehicle_finder_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

class VehicleFinderRepositoryImpl implements VehicleFinderRepository {
  final NetworkService networkService;

  VehicleFinderRepositoryImpl({
    required this.networkService,
  });

  //Add methods here

}
