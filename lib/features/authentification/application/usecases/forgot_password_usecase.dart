//Don't translate me
import 'forgot_password_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/authentification_exception.dart';
import '../../domain/repositories/authentification_repository.dart';
import '../../domain/entities/forgot_password.dart';

class ForgotPasswordUseCase {
  final AuthentificationRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<AuthentificationException, ForgotPassword>> call(ForgotPasswordCommand command) async {
    return await repository.forgotPassword(command.email);  }
}
