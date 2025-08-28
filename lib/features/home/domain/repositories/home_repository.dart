import 'package:dartz/dartz.dart';
import 'package:jappcare/features/home/domain/core/exceptions/home_exception.dart';

abstract class HomeRepository {
  //Add methods here

  Future<Either<HomeException, List<String>>> getTipsList();
}
