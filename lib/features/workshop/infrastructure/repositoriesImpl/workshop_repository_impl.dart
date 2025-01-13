//Don't translate me
import '../../domain/repositories/workshop_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

import '../../../../core/exceptions/base_exception.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/core/utils/workshop_constants.dart';
import 'package:dartz/dartz.dart';


import '../../domain/entities/get_all_services_center.dart';
import '../models/get_all_services_center_model.dart';

class WorkshopRepositoryImpl implements WorkshopRepository {
  final NetworkService networkService;

  WorkshopRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<WorkshopException, GetAllServicesCenter>> getAllServicesCenter() async {
    try {
      final response = await networkService.get(
        WorkshopConstants.getAllServicesCenterGetUri,
        
      );
      return Right(GetAllServicesCenterModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message));
    }
  }






  //Add methods here

}
