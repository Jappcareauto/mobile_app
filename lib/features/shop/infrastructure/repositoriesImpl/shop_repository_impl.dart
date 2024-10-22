//Don't translate me
import '../../domain/repositories/shop_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

class ShopRepositoryImpl implements ShopRepository {
  final NetworkService networkService;

  ShopRepositoryImpl({
    required this.networkService,
  });

  //Add methods here

}
