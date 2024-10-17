//Don't translate me
import '../../domain/repositories/home_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkService networkService;

  HomeRepositoryImpl({
    required this.networkService,
  });

  //Add methods here

}