//Don't translate me
import '../command/get_product_detail.command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/shop_exception.dart';
import '../../domain/repositories/shop_repository.dart';
import '../../domain/entities/get_product_detail.dart';

class GetProductDetailUseCase {
  final ShopRepository repository;

  GetProductDetailUseCase(this.repository);

  Future<Either<ShopException, GetProductDetail>> call(
      GetProductDetailCommand command) async {
    return await repository.getProductDetail(command.productId);
  }
}
