//Don't translate me
import 'change_password_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/authentification_exception.dart';
import '../../domain/repositories/authentification_repository.dart';

class ChangePasswordUseCase {
  final AuthentificationRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<Either<AuthentificationException, bool>> call(
      ChangePasswordCommand command) async {
    return await repository.changePassword(
      oldPassword: command.oldPassword,
      newPassword: command.newPassword,
      confirmPassword: command.confirmPassword,
    );
  }
}
