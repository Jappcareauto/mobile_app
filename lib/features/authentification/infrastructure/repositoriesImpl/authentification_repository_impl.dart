//Don't translate me
import '../../domain/repositories/authentification_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

import '../../domain/entities/login.dart';
import '../../../../core/exceptions/base_exception.dart';
import '../../domain/core/exceptions/authentification_exception.dart';
import '../../domain/core/utils/authentification_constants.dart';
import 'package:dartz/dartz.dart';
import '../models/login_model.dart';
import '../../domain/entities/register.dart';
import '../models/register_model.dart';
import '../../application/usecases/register_command.dart';

import '../../domain/entities/forgot_password.dart';
import '../models/forgot_password_model.dart';

import '../../domain/entities/reset_password.dart';
import '../models/reset_password_model.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthentificationRepositoryImpl implements AuthentificationRepository {
  final NetworkService networkService;

  AuthentificationRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<AuthentificationException, ResetPassword>> resetPassword(
      String code, String newPassword) async {
    try {
      final response = await networkService.post(
        AuthentificationConstants.resetPasswordPostUri,
        body: {
          'code': code,
          'newPassword': newPassword,
        },
      );
      return Right(ResetPasswordModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message));
    }
  }

  @override
  Future<Either<AuthentificationException, ForgotPassword>> forgotPassword(
      String email) async {
    try {
      final response = await networkService.post(
        AuthentificationConstants.forgotPasswordPostUri,
        body: {
          'email': email,
        },
      );
      return Right(ForgotPasswordModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message));
    }
  }

  @override
  Future<Either<AuthentificationException, bool>> resendOtp(
      String email) async {
    try {
      await networkService
          .post("${AuthentificationConstants.resendOtpPostUri}?email=$email");
      return const Right(true);
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message));
    }
  }

  @override
  Future<Either<AuthentificationException, bool>> verifyEmail(
      String code) async {
    try {
      await networkService
          .post("${AuthentificationConstants.verifyEmailPostUri}/$code");
      return const Right(true);
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message));
    }
  }

  @override
  Future<Either<AuthentificationException, Register>> register(
      {required String name,
      String? email,
      required String password,
      PhoneCommand? phone,
      required String dateOfBirth}) async {
    try {
      final response = await networkService.post(
        AuthentificationConstants.registerPostUri,
        body: {
          'name': name,
          'email': email,
          'password': password,
          'phone': email != null
              ? null
              : {
                  'code': phone?.code,
                  'number': phone?.number,
                },
          'dateOfBirth': dateOfBirth,
        },
      );
      return Right(RegisterModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message));
    }
  }

  @override
  Future<Either<AuthentificationException, Login>> login(
      {String? email,
      String? phone,
      required String password,
      bool? extend}) async {
    Map<String, dynamic> loginWithMail = {
      'email': email,
      'password': password,
      'extend': extend,
    };

    Map<String, dynamic> loginWithPhone = {
      'phone': phone,
      'password': password,
      'extend': extend,
    };

    try {
      final response = await networkService.post(
        AuthentificationConstants.loginPostUri,
        body: email != null ? loginWithMail : loginWithPhone,
      );
      return Right(LoginModel.fromJson(response["data"]).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message));
    }
  }

  @override
  Future<Either<AuthentificationException, Login>> googleLogin(
      {required String bearerId}) async {
    try {
      final response = await networkService
          .post(AuthentificationConstants.googleLoginPostUri, headers: {
        'Authorization': 'Bearer $bearerId',
      });
      return Right(LoginModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message));
    }
  }

  @override
  Future<Either<AuthentificationException, Register>> googleRegister(
      {required String bearerId}) async {
    try {
      final response = await networkService
          .post(AuthentificationConstants.googleSignUpPostUri, headers: {
        'Authorization': 'BearerId $bearerId',
      });
      return Right(RegisterModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message));
    }
  }

  @override
  Future<void> googleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: <String>['email'],
    );
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return; // user aborted

      final GoogleSignInAuthentication auth = await account.authentication;
      final String? idToken = auth.idToken;
      final String? accessToken = auth.accessToken;

      if (idToken == null) throw Exception('Missing Google ID Token');
      // Now send `idToken` to your backend
      // await sendTokenToServer(idToken);

      print(account);
      print(accessToken);
      print(idToken);
      await googleLogin(bearerId: idToken);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> googleSignUp() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: <String>['email'],
    );
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return; // user aborted

      final GoogleSignInAuthentication auth = await account.authentication;
      final String? idToken = auth.idToken;
      final String? accessToken = auth.accessToken;

      if (idToken == null) throw Exception('Missing Google ID Token');
      // Now send `idToken` to your backend
      // await sendTokenToServer(idToken);

      print(account);
      print(accessToken);
      print(idToken);
    } catch (e) {
      print(e);
    }
  }

  Future<void> googleLogout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: <String>['email'],
    );

    googleSignIn.disconnect();
  }

  //Add methods here
}
