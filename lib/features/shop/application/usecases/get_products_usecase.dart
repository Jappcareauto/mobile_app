//Don't translate me

import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/shop_exception.dart';
import '../../domain/repositories/shop_repository.dart';
import '../../domain/entities/get_products.dart';

class GetProductsUseCase {
  final ShopRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<ShopException, List<Data>>> call() async {
    return await repository.getProducts();  }
}
