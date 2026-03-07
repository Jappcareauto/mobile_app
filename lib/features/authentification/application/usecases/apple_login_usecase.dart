//Don't translate me
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/authentification_exception.dart';
import '../../domain/repositories/authentification_repository.dart';
import '../../domain/entities/login.dart';

class AppleLoginUseCase {
  final AuthentificationRepository repository;

  AppleLoginUseCase(this.repository);

  Future<Either<AuthentificationException, Login>> call() async {
    return repository.appleSignIn();
  }
}
