//Don't translate me
import 'register_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/authentification_exception.dart';
import '../../domain/repositories/authentification_repository.dart';
import '../../domain/entities/register.dart';

class RegisterUseCase {
  final AuthentificationRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<AuthentificationException, Register>> call(RegisterCommand command) async {
    return await repository.register(command.name,command.email,command.password,command.phone,command.dateOfBirth);  }
}
