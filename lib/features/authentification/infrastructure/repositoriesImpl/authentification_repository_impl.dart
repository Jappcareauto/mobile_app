//Don't translate me
import 'dart:io';
import 'package:flutter/foundation.dart';

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

String padBase64(String base64) {
  int rem = base64.length % 4;
  if (rem > 0) {
    base64 += "=" * (4 - rem);
  }
  return base64;
}

class AuthentificationRepositoryImpl implements AuthentificationRepository {
  final NetworkService networkService;

  AuthentificationRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<AuthentificationException, ResetPassword>> resetPassword(
      {required String email,
      required String code,
      required String newPassword}) async {
    try {
      final response = await networkService.post(
        AuthentificationConstants.resetPasswordPostUri,
        body: {
          'email': email,
          'code': code,
          'newPassword': newPassword,
        },
      );
      return Right(ResetPasswordModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
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
      return Right(ForgotPasswordModel.fromJson(response['data']).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, bool>> resendOtp(
      String email) async {
    try {
      await networkService
          .get("${AuthentificationConstants.resendOtpPostUri}?email=$email");
      return const Right(true);
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, bool>> verifyEmail(
      String code) async {
    try {
      await networkService
          .get("${AuthentificationConstants.verifyEmailPostUri}/$code");
      return const Right(true);
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
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
      // print({
      //   'name': name,
      //   'email': email,
      //   'password': password,
      //   'phone': email != null
      //       ? null
      //       : {
      //           'code': phone?.code,
      //           'number': phone?.number,
      //         },
      //   'dateOfBirth': dateOfBirth,
      // });
      final response = await networkService.post(
        AuthentificationConstants.registerPostUri,
        body: {
          'name': name,
          'email': email,
          'password': password,
          'phone': null,
          'dateOfBirth': dateOfBirth,
        },
      );
      return Right(RegisterModel.fromJson(response['data']).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
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
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, Login>> googleLogin(
      {required String bearerId}) async {
    try {
      final response = await networkService
          .post(AuthentificationConstants.googleLoginPostUri, headers: {
        'Authorization': 'BearerId $bearerId',
        'Platform': Platform.isAndroid
            ? 'Android'
            : Platform.isIOS
                ? 'Ios'
                : 'Web',
      });
      return Right(LoginModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, Register>> googleRegister(
      {required String bearerId}) async {
    try {
      final response = await networkService
          .post(AuthentificationConstants.googleLoginPostUri, headers: {
        'Authorization': 'BearerId $bearerId',
        'Platform': Platform.isAndroid
            ? 'Android'
            : Platform.isIOS
                ? 'Ios'
                : 'Web',
      });
      return Right(RegisterModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, Login>> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: <String>['email'],
    );
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) {
        throw Exception('The account was not found'); // user aborted
      }

      final GoogleSignInAuthentication auth = await account.authentication;
      final String? idToken = auth.idToken;
      // final String? accessToken = auth.accessToken;

      if (idToken == null) throw Exception('Missing Google ID Token');
      // Now send `idToken` to your backend
      // await sendTokenToServer(idToken);

      // print(account);
      // print(accessToken);
      // print('BearerId $idToken');
      // String base64IdToken = base64Url.encode(utf8.encode(idToken));
      // print(base64IdToken);
      List<String> part = idToken.split("."); // or 1 or 2
      String part0 = part[0];
      String fixed = padBase64(part0); // add padding if needed
      String finalToken = [fixed, part[1], part[2]].join(".");
      debugPrint('final token $finalToken ${finalToken.length}');
      debugPrint('idToken $idToken ${idToken.length}');

      // print(idToken.length);
      return await googleLogin(bearerId: finalToken);
    } on BaseException catch (e) {
      print(e);
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, Register>> googleSignUp() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: <String>['email'],
    );
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) {
        throw Exception('The account was not found'); // user aborted
      }

      final GoogleSignInAuthentication auth = await account.authentication;
      final String? idToken = auth.idToken;
      final String? accessToken = auth.accessToken;

      if (idToken == null) throw Exception('Missing Google ID Token');
      // Now send `idToken` to your backend
      // await sendTokenToServer(idToken);

      print(account);
      print(accessToken);
      print(idToken);
      return await googleRegister(bearerId: idToken);
    } on BaseException catch (e) {
      print(e);
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  // @override
  // Future<void> googleSignUp() async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn(
  //     scopes: <String>['email'],
  //   );
  //   try {
  //     final GoogleSignInAccount? account = await googleSignIn.signIn();
  //     if (account == null) return; // user aborted

  //     final GoogleSignInAuthentication auth = await account.authentication;
  //     final String? idToken = auth.idToken;
  //     final String? accessToken = auth.accessToken;

  //     if (idToken == null) throw Exception('Missing Google ID Token');
  //     // Now send `idToken` to your backend
  //     // await sendTokenToServer(idToken);

  //     print(account);
  //     print(accessToken);
  //     print(idToken);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> googleLogout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: <String>['email'],
    );

    googleSignIn.disconnect();
  }

  //Add methods here
}
