//Don't translate me
import 'package:jappcare/features/profile/application/command/update_profile_command.dart';
import 'package:jappcare/features/profile/domain/entities/get_user_infos.dart';

import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/profile_exception.dart';
import '../../domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<ProfileException, GetUserInfos>> call(
      UpdateProfileCommand command) async {
    return await repository.updateUserInfos(
        name: command.name,
        email: command.email,
        dateOfBirth: command.dateOfBirth,
        address: command.address,
        phone: command.phone);
  }
}
