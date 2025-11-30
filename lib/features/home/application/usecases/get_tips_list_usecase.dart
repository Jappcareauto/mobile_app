import 'package:dartz/dartz.dart';
import 'package:jappcare/features/home/domain/core/exceptions/home_exception.dart';
import 'package:jappcare/features/home/domain/entities/get_tips_list.entity.dart';
import 'package:jappcare/features/home/domain/repositories/home_repository.dart';

class GetTipsListUseCase {
  final HomeRepository repository;

  GetTipsListUseCase(this.repository);

  Future<Either<HomeException, List<TipEntity>>> call() async {
    return await repository.getTipsList();
  }
}
