//Don't translate me
import 'update_profile_image_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/profile_exception.dart';
import '../../domain/repositories/profile_repository.dart';

class UpdateProfileImageUseCase {
  final ProfileRepository repository;

  UpdateProfileImageUseCase(this.repository);

  Future<Either<ProfileException, bool>> call(UpdateProfileImageCommand command) async {
    return await repository.updateProfileImage(command.userId,command.file);  }
}
