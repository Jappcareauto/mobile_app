//Don't translate me
import 'dart:io';

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
      // According to API docs, use the same endpoint but with multipart/form-data
      // Upload the image first
      final files = await uploadImages([file]);

      if (files != null) {
        // Use the update-details endpoint with multipart/form-data
        await networkService.put(
          ProfileConstants.updateUserDetailsUri,
          body: {'profileImage': files.first},
        );
        return const Right(true);
      } else {
        throw Exception("Couldn't upload the user profile picture");
      }
    } on BaseException catch (e) {
      return Left(ProfileException(e.message, e.statusCode));
    } catch (e) {
      print("Couldn't upload the files: ${e.toString()}");
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
      String? phoneCode}) async {
    print("Phone: $phone, phoneCode: $phoneCode");
    try {
      // Build the request body according to API documentation
      Map<String, dynamic> requestBody = {
        'name': name,
        'dateOfBirth': dateOfBirth,
      };

      // Add phone if provided (with correct structure)
      if (phone != null) {
        requestBody['phone'] = {
          'countryCode': "+${phone.code}",
          'number': phone.number,
        };
      }

      // Add location if provided
      if (location != null) {
        requestBody['location'] = {
          'latitude': location.latitude,
          'longitude': location.longitude,
          'name': location.name,
          if (location.description != null && location.description!.isNotEmpty)
            'description': location.description,
        };
      }

      final response = await networkService
          .put(ProfileConstants.updateUserDetailsUri, body: requestBody);
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
