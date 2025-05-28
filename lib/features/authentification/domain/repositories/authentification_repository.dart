import 'package:dartz/dartz.dart';
import '../core/exceptions/authentification_exception.dart';
import '../entities/login.dart';
import '../entities/register.dart';
import '../../application/usecases/register_command.dart';
import '../entities/forgot_password.dart';
import '../entities/reset_password.dart';

abstract class AuthentificationRepository {
  //Add methods here
  Future<Either<AuthentificationException, Login>> login(
      {String? email, String? phone, required String password, bool? extend});

  Future<Either<AuthentificationException, Login>> googleLogin(
      {required String bearerId});

  Future<Either<AuthentificationException, Register>> googleRegister(
      {required String bearerId});

  Future<Either<AuthentificationException, Login>> googleSignIn();

  Future<Either<AuthentificationException, Register>> googleSignUp();

  Future<Either<AuthentificationException, Register>> register(
      {required String name,
      String? email,
      required String password,
      PhoneCommand? phone,
      required String dateOfBirth});

  // Future<Either<AuthentificationException, Register>> googleRegister(
  //     {required String bearerId});

  Future<Either<AuthentificationException, bool>> verifyEmail(String code);

  Future<Either<AuthentificationException, bool>> resendOtp(String email);

  Future<Either<AuthentificationException, ForgotPassword>> forgotPassword(
      String email);

  Future<Either<AuthentificationException, ResetPassword>> resetPassword(
      String code, String newPassword);
}
