//Don't translate me
import 'dart:io';

import 'package:jappcare/core/ui/domain/entities/location.entity.dart';
import 'package:jappcare/features/profile/domain/entities/update_user_details.dart';
import 'package:jappcare/features/profile/infrastructure/models/update_user_details_model.dart';

import '../../domain/repositories/profile_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

import '../../domain/entities/get_user_infos.dart';
import '../../../../core/exceptions/base_exception.dart';
import '../../domain/core/exceptions/profile_exception.dart';
import '../../domain/core/utils/profile_constants.dart';
import 'package:dartz/dartz.dart';
import '../models/get_user_infos_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final NetworkService networkService;

  ProfileRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<ProfileException, bool>> updateProfileImage(
      String userId, String file) async {
    try {
      await networkService.put(
        "${ProfileConstants.updateProfileImagePutUri}/$userId/update-image",
        files: {'file': File(file)},
      );
      return const Right(true);
    } on BaseException catch (e) {
      return Left(ProfileException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<ProfileException, GetUserInfos>> getUserInfos() async {
    try {
      final response = await networkService.get(
        ProfileConstants.getUserInfosGetUri,
      );
      return Right(GetUserInfosModel.fromJson(response["data"]).toEntity());
    } on BaseException catch (e) {
      return Left(ProfileException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<ProfileException, UpdateUserDetails>> updateUserInfos(
      {required String name,
      required String email,
      required String dateOfBirth,
      LocationEntity? location,
      String? address,
      String? phone}) async {
        print(location);
    try {
      final response = await networkService.put(
        ProfileConstants.updateUserDetailsUri,
        body:  {
          'name': name,
          // 'email': email,
          'dateOfBirth': dateOfBirth,
          if (location != null) 'location': {
            'latitude': location.latitude,
            'longitude': location.longitude,
            'name': location.name,
            'description': location.description,
          },
          // if (address != null) 'location': address,
          // if (phone != null) 'phone': phone,
        }
      );
      return Right(UpdateUserDetailsModel.fromJson(response["data"]).toEntity());
    } on BaseException catch (e) {
      return Left(ProfileException(e.message, e.statusCode));
    }
  }

  //Add methods here
}
