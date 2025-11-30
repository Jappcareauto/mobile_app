//Don't translate me
import '../../domain/repositories/shop_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

import '../../domain/entities/get_products.dart';
import '../../../../core/exceptions/base_exception.dart';
import '../../domain/core/exceptions/shop_exception.dart';
import '../../domain/core/utils/shop_constants.dart';
import 'package:dartz/dartz.dart';
import '../models/get_products_model.dart';

import '../../domain/entities/get_product_detail.dart';
import '../models/get_product_detail_model.dart';

import '../../domain/entities/get_review.dart';
import '../models/get_review_model.dart';

class ShopRepositoryImpl implements ShopRepository {
  final NetworkService networkService;

  ShopRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<ShopException, GetReview>> getReview(String productId) async {
    try {
      final response = await networkService.get(
        "${ShopConstants.getReviewGetUri}/$productId",
      );
      return Right(GetReviewModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(ShopException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<ShopException, GetProductDetail>> getProductDetail(
      String productId) async {
    try {
      final response = await networkService.get(
        "${ShopConstants.getProductDetailGetUri}/$productId",
      );
      return Right(GetProductDetailModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(ShopException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<ShopException, List<Data>>> getProducts() async {
    try {
      final response = await networkService.get(
        ShopConstants.getProductsGetUri,
      );
      final List<dynamic> decodedResponse = response;
      final products = decodedResponse
          .map((json) => DataModel.fromJson(json).toEntity())
          .toList();
      return Right(products);
    } on BaseException catch (e) {
      return Left(ShopException(e.message, e.statusCode));
    }
  }

//Add methods here
}
