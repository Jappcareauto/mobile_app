//Don't translate me
import '../../domain/repositories/profile_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final NetworkService networkService;

  ProfileRepositoryImpl({
    required this.networkService,
  });

  //Add methods here

}
