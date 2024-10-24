//Don't translate me
import 'resend_otp_command.dart';
import 'package:dartz/dartz.dart';
import '../../domain/core/exceptions/authentification_exception.dart';
import '../../domain/repositories/authentification_repository.dart';

class ResendOtpUseCase {
  final AuthentificationRepository repository;

  ResendOtpUseCase(this.repository);

  Future<Either<AuthentificationException, bool>> call(ResendOtpCommand command) async {
    return await repository.resendOtp(command.email);  }
}
