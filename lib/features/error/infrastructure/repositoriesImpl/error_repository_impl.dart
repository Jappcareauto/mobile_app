//Don't translate me
import '../../domain/repositories/error_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

class ErrorRepositoryImpl implements ErrorRepository {
  final NetworkService networkService;

  ErrorRepositoryImpl({
    required this.networkService,
  });

  //Add methods here

}
