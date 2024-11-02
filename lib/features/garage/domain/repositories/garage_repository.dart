import 'package:dartz/dartz.dart';

import '../core/exceptions/garage_exception.dart';
import '../entities/get_garage_by_owner_id.dart';


abstract class
 GarageRepository {
  //Add methods here
  Future<Either<GarageException, GetGarageByOwnerId>> getGarageByOwnerId(String userId);

}


