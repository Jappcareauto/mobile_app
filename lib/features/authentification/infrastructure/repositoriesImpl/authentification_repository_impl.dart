//Don't translate me
import 'dart:io';

import 'package:jappcare/features/authentification/application/usecases/phone_command.dart';

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

import '../../domain/entities/forgot_password.dart';
import '../models/forgot_password_model.dart';

import '../../domain/entities/reset_password.dart';
import '../models/reset_password_model.dart';

import 'package:google_sign_in/google_sign_in.dart';

void printWrapped(String text) {
  // 800 is a good chunk size that should prevent truncation.
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

Future<void> _initializeGoogleSignIn() async {
  try {
    print('Initializing Google Sign-In');
    await _googleSignIn.initialize(
        serverClientId:
            "303138649390-cmphfbl2cseqbpqmc28ie7a141hq8utg.apps.googleusercontent.com"
        // "415070003598-pc9dsnpisbn9uvil4lpuh339bh6ran3p.apps.googleusercontent.com"
        );
  } catch (e) {
    print('Failed to initialize Google Sign-In: $e');
  }
}

Future<GoogleSignInAccount?> signInWithGoogle() async {
  try {
    // It now throws a `GoogleSignInException` if the user cancels.
    return await _googleSignIn.authenticate(
      scopeHint: ['email', 'profile'],
    );
  } on GoogleSignInException catch (e) {
    // You can now check the error code for specific cases, like cancellation.
    if (e.code == GoogleSignInExceptionCode.canceled) {
      // User cancelled
      return null;
    }
    rethrow;
  } catch (error) {
    print('Unexpected Google Sign-In error: $error');
    rethrow;
  }
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
      PhoneCommand? phone,
      required String password,
      bool? extend}) async {
    try {
      final response = await networkService.post(
        AuthentificationConstants.loginPostUri,
        body: {
          if (email != null) 'email': email,
          if (phone != null)
            'phone': {'code': phone.code, 'number': phone.number},
          'password': password,
          'extend': extend,
        },
      );
      return Right(LoginModel.fromJson(response["data"]).toEntity());
    } on BaseException catch (e) {
      print(e.message);
      String errorMessage = e.message;

      // Handle specific authentication errors
      if (e.statusCode == 401) {
        errorMessage = 'Invalid email or password';
      } else if (e.statusCode == 403) {
        errorMessage = 'Access denied. Please check your credentials.';
      } else if (e.statusCode == 404 && email != null) {
        errorMessage = 'User not found with email: $email';
      } else if (e.statusCode == 404 && phone != null) {
        errorMessage =
            'User not found with phone: ${phone.code}${phone.number}';
      } else if (errorMessage.isEmpty) {
        errorMessage = 'Login failed. Please try again.';
      } else if (e.statusCode == 500) {
        errorMessage = 'Invalid email or password';
      }

      return Left(AuthentificationException(errorMessage, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, Login>> googleLogin(
      {required String bearerId}) async {
    try {
      print('BearerId#');
      printWrapped(bearerId);
      print('End printing');
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
  Future<Either<AuthentificationException, Login>> googleLogin2(
      {required String bearerId,
      required String email,
      required String name}) async {
    try {
      // debugPrint(bearerId);
      print('BearerId#');
      printWrapped(bearerId);
      print('End printing');
      final response = await networkService
          .post(AuthentificationConstants.googleLoginPostUri2, headers: {
        'Authorization': 'BearerId# $bearerId',
        'Email': email,
        'Name': name,
      });
      return Right(LoginModel.fromJson(response['data']).toEntity());
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
  Future<Either<AuthentificationException, Register>> googleRegister2(
      {required String bearerId,
      required String email,
      required String name}) async {
    try {
      final response = await networkService
          .post(AuthentificationConstants.googleLoginPostUri2, headers: {
        'Authorization': 'BearerId# $bearerId',
        'Email': email,
        'Name': name,
      });
      return Right(RegisterModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<AuthentificationException, Login>> googleSignIn() async {
    try {
      await _initializeGoogleSignIn();
      final GoogleSignInAccount? account = await signInWithGoogle();

      if (account == null) {
        throw Exception('The account was not found'); // user aborted
      }

      final GoogleSignInAuthentication auth = account.authentication;
      final String? idToken = auth.idToken;

      if (idToken == null) throw Exception('Missing Google ID Token');

      // return await googleLogin(bearerId: idToken);
      return await googleLogin(bearerId: idToken);
    } on BaseException catch (e) {

      return Left(AuthentificationException(e.message, e.statusCode));
    } catch (e) {
      return Left(AuthentificationException(e.toString(), 0));
    }
  }

  @override
  Future<Either<AuthentificationException, Register>> googleSignUp() async {
    try {
      await _initializeGoogleSignIn();
      final GoogleSignInAccount? account = await signInWithGoogle();
      if (account == null) {
        throw Exception('The account was not found'); // user aborted
      }

      final GoogleSignInAuthentication auth = account.authentication;
      final String? idToken = auth.idToken;

      if (idToken == null) throw Exception('Missing Google ID Token');

      // return await googleRegister(bearerId: idToken);
      return await googleRegister2(
          bearerId: idToken,
          email: account.email,
          name: account.displayName ?? "");
    } on BaseException catch (e) {
      print(e);
      return Left(AuthentificationException(e.message, e.statusCode));
    } catch (e) {
      return Left(AuthentificationException(e.toString(), 0));
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
    // final GoogleSignIn googleSignIn = GoogleSignIn(
    //   scopes: <String>['email'],
    // );

    _googleSignIn.disconnect();
  }

  //Add methods here
}
