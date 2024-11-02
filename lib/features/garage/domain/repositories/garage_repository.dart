import 'package:dartz/dartz.dart';

import '../core/exceptions/garage_exception.dart';
import '../entities/get_garage_by_owner_id.dart';



import '../entities/get_vehicle_list.dart';




import '../entities/add_vehicle.dart';


abstract class



 GarageRepository {
  //Add methods here
  Future<Either<GarageException, GetGarageByOwnerId>> getGarageByOwnerId(String userId);

  Future<Either<GarageException, List<GetVehicleList>>> getVehicleList(String garageId);


  Future<Either<GarageException, AddVehicle>> addVehicle(String garageId, String vin);

}





