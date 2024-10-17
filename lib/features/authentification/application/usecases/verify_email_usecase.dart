//Don't translate me
import 'verify_email_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/authentification_exception.dart';
import '../../domain/repositories/authentification_repository.dart';

class VerifyEmailUseCase {
  final AuthentificationRepository repository;

  VerifyEmailUseCase(this.repository);

  Future<Either<AuthentificationException, bool>> call(VerifyEmailCommand command) async {
    return await repository.verifyEmail(command.code);  }
}
