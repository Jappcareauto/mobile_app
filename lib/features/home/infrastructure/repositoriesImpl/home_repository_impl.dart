//Don't translate me
import 'package:dartz/dartz.dart';
import 'package:jappcare/core/exceptions/base_exception.dart';
import 'package:jappcare/features/home/domain/core/exceptions/home_exception.dart';
import 'package:jappcare/features/home/domain/entities/get_tips_list.entity.dart';
import 'package:jappcare/features/home/infrastructure/models/get_all_tips.model.dart';

import '../../domain/repositories/home_repository.dart';
import '../../domain/core/utils/home_constants.dart';
import '../../../../core/services/networkServices/network_service.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkService networkService;

  HomeRepositoryImpl({
    required this.networkService,
  });

  //Add methods here

  @override
  Future<Either<HomeException, List<TipEntity>>> getTipsList() async {
    try {
      final response =
          await networkService.post(HomeConstants.getTipsListUri, body: {});
      return Right((response['data'] as List).map((e) => TipModel.fromJson(e).toEntity()).toList());
    } on BaseException catch (e) {
      return Left(HomeException(e.message, e.statusCode));
    }
  }
}
