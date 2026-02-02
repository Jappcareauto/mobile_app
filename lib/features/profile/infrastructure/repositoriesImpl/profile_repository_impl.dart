//Don't translate me
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' hide Response;
import 'package:jappcare/core/ui/domain/entities/location.entity.dart';
import 'package:jappcare/core/utils/enums.dart';
import 'package:jappcare/features/authentification/application/usecases/phone_command.dart';
import 'package:jappcare/features/profile/domain/entities/update_user_details.dart';
import 'package:jappcare/features/profile/infrastructure/models/update_user_details_model.dart';

import '../../domain/repositories/profile_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

import '../../domain/entities/get_user_infos.dart';
import '../../../../core/exceptions/base_exception.dart';
import '../../domain/core/exceptions/profile_exception.dart';
import '../../domain/core/utils/profile_constants.dart';
import 'package:dartz/dartz.dart';
import '../models/get_user_infos_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final NetworkService networkService;

  ProfileRepositoryImpl({
    required this.networkService,
  });

  Future<List<String>?> uploadImages(List<File> files) async {
    try {
      final response = await networkService.post(
        ProfileConstants.uploadImagesUri,
        files: {for (var elemt in files) "files": elemt},
      );
      return response['data'];
    } on BaseException catch (e) {
      print("Couldn't upload the files: ${e.message}, code: ${e.statusCode}");
      return null;
    } catch (e) {
      print("Couldn't upload the files: ${e.toString()}");
      return null;
    }
  }

  @override
  Future<Either<ProfileException, bool>> updateProfileImage(
      String userId, File file) async {
    try {
      // According to new API docs, use multipart/form-data with profileImage only
      await networkService.put(
        ProfileConstants.updateUserDetailsUri,
        files: {'profileImage': file},
      );
      return const Right(true);
    } on BaseException catch (e) {
      return Left(ProfileException(e.message, e.statusCode));
    } catch (e) {
      print("Couldn't upload the profile image: ${e.toString()}");
      return Left(ProfileException(e.toString(), 500));
    }
  }

  @override
  Future<Either<ProfileException, GetUserInfos>> getUserInfos() async {
    try {
      final response = await networkService.get(
        ProfileConstants.getUserInfosGetUri,
      );
      return Right(GetUserInfosModel.fromJson(response["data"]).toEntity());
    } on BaseException catch (e) {
      return Left(ProfileException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<ProfileException, UpdateUserDetails>> updateUserInfos(
      {required String name,
      required String email,
      required String dateOfBirth,
      LocationEntity? location,
      PhoneCommand? phone,
      String? phoneCode,
      File? profileImage}) async {
    print("Phone: $phone, phoneCode: $phoneCode");
    try {
      // Build the details JSON according to new API documentation
      Map<String, dynamic> details = {};

      // Add name if provided
      if (name.isNotEmpty) {
        details['name'] = name;
      }

      // Add dateOfBirth if provided (format: YYYY-MM-DD)
      if (dateOfBirth.isNotEmpty) {
        details['dateOfBirth'] = dateOfBirth;
      }

      // Add phone if provided (with correct structure: code and number)
      if (phone != null && phone.number.isNotEmpty) {
        details['phone'] = {
          'code': phone.code, // Country code like "CM" or "237"
          'number': phone.number,
        };
      }

      // Build FormData for multipart request
      final formData = FormData();

      // Add details as JSON MultipartFile with application/json content type
      if (details.isNotEmpty) {
        formData.files.add(MapEntry(
          'details',
          MultipartFile.fromString(
            jsonEncode(details),
            contentType: DioMediaType('application', 'json'),
          ),
        ));
      }

      // Add profile image if provided
      if (profileImage != null) {
        formData.files.add(MapEntry(
          'profileImage',
          await MultipartFile.fromFile(
            profileImage.path,
            filename: profileImage.path.split('/').last,
          ),
        ));
      }

      final response = await networkService.put(
        ProfileConstants.updateUserDetailsUri,
        body: formData,
      );

      return Right(
          UpdateUserDetailsModel.fromJson(response["data"]).toEntity());
    } on BaseException catch (e) {
      return Left(ProfileException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<ProfileException, String>> addPaymentMethod(
      {required PaymentMethod type, PhoneCommand? phone}) async {
    try {
      final response = await networkService
          .post(ProfileConstants.updateUserDetailsUri, body: {
        "userId": "",
        "paymentMethod": type.name,
        "approved": "",
        "mobileMoney": {"mobileWalletNumber": "${phone?.code}${phone?.number}"}
      });
      // return Right(UpdateUserDetailsModel.fromJson(response["data"]).toEntity());
      return Right("${response["data"]}");
    } on BaseException catch (e) {
      return Left(ProfileException(e.message, e.statusCode));
    }
  }

  //Add methods here
}
