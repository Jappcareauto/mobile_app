//Don't translate me
import '../../domain/repositories/workshop_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

import '../../../../core/exceptions/base_exception.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/core/utils/workshop_constants.dart';
import 'package:dartz/dartz.dart';


class WorkshopRepositoryImpl implements WorkshopRepository {
  final NetworkService networkService;

  WorkshopRepositoryImpl({
    required this.networkService,
  });





  //Add methods here

}
