//Don't translate me

import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/profile_exception.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/entities/get_user_infos.dart';

class GetUserInfosUseCase {
  final ProfileRepository repository;

  GetUserInfosUseCase(this.repository);

  Future<Either<ProfileException, GetUserInfos>> call() async {
    return await repository.getUserInfos();  }
}
