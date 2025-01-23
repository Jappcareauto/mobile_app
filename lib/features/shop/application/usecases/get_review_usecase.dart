//Don't translate me
import 'get_review_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/shop_exception.dart';
import '../../domain/repositories/shop_repository.dart';
import '../../domain/entities/get_review.dart';

class GetReviewUseCase {
  final ShopRepository repository;

  GetReviewUseCase(this.repository);

  Future<Either<ShopException, GetReview>> call(GetReviewCommand command) async {
    return await repository.getReview(command.productId);  }
}
