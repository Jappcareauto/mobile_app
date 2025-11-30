import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jappcare/core/ui/domain/entities/location.entity.dart';
import 'package:jappcare/core/utils/enums.dart';
import 'package:jappcare/features/authentification/application/usecases/phone_command.dart';
import 'package:jappcare/features/profile/domain/entities/update_user_details.dart';

import '../core/exceptions/profile_exception.dart';
import '../entities/get_user_infos.dart';

abstract class ProfileRepository {
  //Add methods here
  Future<Either<ProfileException, GetUserInfos>> getUserInfos();

  Future<Either<ProfileException, bool>> updateProfileImage(
      String userId, File file);

  Future<Either<ProfileException, UpdateUserDetails>> updateUserInfos(
      {required String name,
      required String email,
      required String dateOfBirth,
      LocationEntity? location,
      PhoneCommand? phone,
      });

  Future<Either<ProfileException, String>> addPaymentMethod({
    required PaymentMethod type,
    PhoneCommand? phone,
  });
}
