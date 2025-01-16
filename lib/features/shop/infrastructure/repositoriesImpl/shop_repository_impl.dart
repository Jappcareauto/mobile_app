//Don't translate me
import '../../domain/repositories/shop_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

import '../../domain/entities/get_products.dart';
import '../../../../core/exceptions/base_exception.dart';
import '../../domain/core/exceptions/shop_exception.dart';
import '../../domain/core/utils/shop_constants.dart';
import 'package:dartz/dartz.dart';
import '../models/get_products_model.dart';

class ShopRepositoryImpl implements ShopRepository {
  final NetworkService networkService;

  ShopRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<ShopException, List<Data>>> getProducts() async {
    try {
      final response = await networkService.get(
        ShopConstants.getProductsGetUri,
      );
      final List<dynamic> decodedResponse = response;
      final products = decodedResponse.map((json) => DataModel.fromJson(json).toEntity()).toList();
      return Right(products);
    } on BaseException catch (e) {
      return Left(ShopException(e.message));
    }
  }



//Add methods here

}
