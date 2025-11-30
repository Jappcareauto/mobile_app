import 'package:dartz/dartz.dart';
import 'package:jappcare/features/home/domain/core/exceptions/home_exception.dart';
import 'package:jappcare/features/home/domain/entities/get_tips_list.entity.dart';

abstract class HomeRepository {
  //Add methods here

  Future<Either<HomeException, List<TipEntity>>> getTipsList();
}
