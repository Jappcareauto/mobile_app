//Don't translate me
import 'dart:io';

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
      return Left(ProfileException(e.message));
    }
  }

  @override
  Future<Either<ProfileException, GetUserInfos>> getUserInfos() async {
    try {
      final response = await networkService.get(
        ProfileConstants.getUserInfosGetUri,
      );
      return Right(GetUserInfosModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(ProfileException(e.message));
    }
  }

  //Add methods here
}
