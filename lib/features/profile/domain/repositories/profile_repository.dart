import 'package:dartz/dartz.dart';

import '../core/exceptions/profile_exception.dart';
import '../entities/get_user_infos.dart';






abstract class

 ProfileRepository {
  //Add methods here
  Future<Either<ProfileException, GetUserInfos>> getUserInfos();

  Future<Either<ProfileException, bool>> updateProfileImage(String userId, String file);

}



