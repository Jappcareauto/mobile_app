import 'package:dartz/dartz.dart';
import '../core/exceptions/authentification_exception.dart';
import '../entities/login.dart';
import '../entities/register.dart';
import '../../application/usecases/register_command.dart';
import '../entities/forgot_password.dart';
import '../entities/reset_password.dart';

abstract class

 AuthentificationRepository {
  //Add methods here
  Future<Either<AuthentificationException, Login>> login(String email, String password, bool? extend);

  Future<Either<AuthentificationException, Register>> register(String name, String email, String password, PhoneCommand phone, String dateOfBirth);

  Future<Either<AuthentificationException, bool>> verifyEmail(String code);

  Future<Either<AuthentificationException, bool>> resendOtp(String email);

  Future<Either<AuthentificationException, ForgotPassword>> forgotPassword(String email);

  Future<Either<AuthentificationException, ResetPassword>> resetPassword(String code, String newPassword);

}





