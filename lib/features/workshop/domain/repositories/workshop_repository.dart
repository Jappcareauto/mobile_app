import 'package:dartz/dartz.dart';

import '../core/exceptions/workshop_exception.dart';




import '../entities/get_all_services_center.dart';


abstract class

 WorkshopRepository {
  //Add methods here

  Future<Either<WorkshopException, GetAllServicesCenter>> getAllServicesCenter();

}



