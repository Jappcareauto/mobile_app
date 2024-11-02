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

class AuthentificationRepositoryImpl implements AuthentificationRepository {
  final NetworkService networkService;

  AuthentificationRepositoryImpl({
    required this.networkService,
  });

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
      String name,
      String email,
      String password,
      PhoneCommand phone,
      String dateOfBirth) async {
    try {
      final response = await networkService.post(
        AuthentificationConstants.registerPostUri,
        body: {
          'name': name,
          'email': email,
          'password': password,
          // 'phone': {
          //   'code': phone.code,
          //   'number': phone.number,
          // },
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
      String email, String password, bool? extend) async {
    try {
      final response = await networkService.post(
        AuthentificationConstants.loginPostUri,
        body: {
          'email': email,
          'password': password,
          'extend': extend,
        },
      );
      return Right(LoginModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(AuthentificationException(e.message));
    }
  }

  //Add methods here
}
