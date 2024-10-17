//Don't translate me
import 'login_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/authentification_exception.dart';
import '../../domain/repositories/authentification_repository.dart';
import '../../domain/entities/login.dart';

class LoginUseCase {
  final AuthentificationRepository repository;

  LoginUseCase(this.repository);

  Future<Either<AuthentificationException, Login>> call(LoginCommand command) async {
    return await repository.login(command.email,command.password,command.extend);  }
}
