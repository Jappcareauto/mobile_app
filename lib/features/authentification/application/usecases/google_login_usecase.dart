//Don't translate me
import 'package:jappcare/features/authentification/application/usecases/google_login_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/authentification_exception.dart';
import '../../domain/repositories/authentification_repository.dart';
import '../../domain/entities/login.dart';

class GoogleLoginUseCase {
  final AuthentificationRepository repository;

  GoogleLoginUseCase(this.repository);

  Future<Either<AuthentificationException, Login>> call(
      GoogleLoginCommand command) async {
    return await repository.googleLogin(bearerId: command.bearerId);
  }
}
