//Don't translate me
// import 'package:jappcare/features/authentification/application/usecases/google_login_command.dart';
import 'package:dartz/dartz.dart';
import 'package:jappcare/features/authentification/domain/entities/register.dart';
import '../../domain/core/exceptions/authentification_exception.dart';
import '../../domain/repositories/authentification_repository.dart';
// import '../../domain/entities/login.dart';

class GoogleSignupUseCase {
  final AuthentificationRepository repository;

  GoogleSignupUseCase(this.repository);

  // Future<Either<AuthentificationException, Login>> call(
  Future<Either<AuthentificationException, Register>> call() async {
    return repository.googleSignUp();
  }
}
