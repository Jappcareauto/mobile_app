//Don't translate me
import 'reset_password_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/authentification_exception.dart';
import '../../domain/repositories/authentification_repository.dart';
import '../../domain/entities/reset_password.dart';

class ResetPasswordUseCase {
  final AuthentificationRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<AuthentificationException, ResetPassword>> call(
      ResetPasswordCommand command) async {
    return await repository.resetPassword(
        code: command.code,
        newPassword: command.newPassword,
        email: command.email);
  }
}
