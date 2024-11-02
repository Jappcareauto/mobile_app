//Don't translate me
import '../../domain/repositories/garage_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

import '../../domain/entities/get_garage_by_owner_id.dart';
import '../../../../core/exceptions/base_exception.dart';
import '../../domain/core/exceptions/garage_exception.dart';
import '../../domain/core/utils/garage_constants.dart';
import 'package:dartz/dartz.dart';
import '../models/get_garage_by_owner_id_model.dart';

class GarageRepositoryImpl implements GarageRepository {
  final NetworkService networkService;

  GarageRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<GarageException, GetGarageByOwnerId>> getGarageByOwnerId(String userId) async {
    try {
      final response = await networkService.get(
        "${GarageConstants.getGarageByOwnerIdGetUri}/$userId",
        
      );
      return Right(GetGarageByOwnerIdModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(GarageException(e.message));
    }
  }


  //Add methods here

}
