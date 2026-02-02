//Don't translate me
import 'package:jappcare/features/profile/application/command/update_profile_command.dart';

import 'package:dartz/dartz.dart';
import 'package:jappcare/features/profile/domain/entities/update_user_details.dart';
import '../../domain/core/exceptions/profile_exception.dart';
import '../../domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<ProfileException, UpdateUserDetails>> call(
      UpdateProfileCommand command) async {
    return await repository.updateUserInfos(
      name: command.name,
      email: command.email,
      dateOfBirth: command.dateOfBirth,
      location: command.location,
      phone: command.phone,
      profileImage: command.profileImage,
    );
  }
}
