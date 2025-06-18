//Don't translate me
import 'package:dio/dio.dart';
import 'package:jappcare/features/garage/domain/core/utils/garage_constants.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:jappcare/features/garage/infrastructure/models/get_vehicle_list_model.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_service_center_services.entity.dart';
import 'package:jappcare/features/workshop/domain/entities/place_details.dart';
import 'package:jappcare/features/workshop/infrastructure/models/place_prediction_model.dart';
import 'package:jappcare/features/workshop/infrastructure/models/place_details_model.dart';
import 'package:jappcare/features/workshop/domain/entities/place_prediction.dart';

import '../../domain/repositories/workshop_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

import '../../../../core/exceptions/base_exception.dart';
import '../../domain/core/exceptions/workshop_exception.dart';
import '../../domain/core/utils/workshop_constants.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/get_all_services_center.entity.dart';
import '../models/get_all_service_center_model.dart';

import '../../domain/entities/book_appointment.dart';
import '../models/book_appointment_model.dart';

// import '../../domain/entities/created_rome_chat.dart';
// import '../models/created_rome_chat_model.dart';

import '../../domain/entities/get_all_services.entity.dart';
import '../models/get_all_services_model.dart';
import '../models/get_all_service_center_services_model.dart';

class WorkshopRepositoryImpl implements WorkshopRepository {
  final NetworkService networkService;
  WorkshopRepositoryImpl({
    required this.networkService,
  });

  @override
  Future<Either<WorkshopException, Vehicle>> getVehiculById(
      String userId) async {
    try {
      final response = await networkService.get(
        "${WorkshopConstants.getVehiculByIdGetUri}/$userId",
      );
      return Right(VehicleModel.fromJson(response["data"]).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<WorkshopException, GetAllServicesEntity>>
      getAllservices() async {
    try {
      final response = await networkService
          .post(WorkshopConstants.getAllservicesGetUri, body: {});
      return Right(GetAllServicesModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<WorkshopException, BookAppointment>> bookAppointment({
    required String date,
    required String locationType,
    String? note,
    required String serviceId,
    required String vehicleId,
    required String timeOfDay,
    required String createdBy,
    required String serviceCenterId,
  }) async {
    try {
      final response = await networkService.post(
        WorkshopConstants.bookAppointmentPostUri,
        body: {
          'id': "",
          "createdBy": createdBy,
          "updatedBy": createdBy,
          "createdAt": date,
          "updatedAt": date,
          'date': date,
          'location': null,
          'locationType': locationType,
          'note': note,
          'serviceId': serviceId,
          'serviceCenterId': serviceCenterId,
          'vehicleId': vehicleId,
          'status': "NOT_STARTED",
          'timeOfDay': timeOfDay,
        },
      );
      return Right(BookAppointmentModel.fromJson(response["data"]).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<WorkshopException, GetAllServiceCenterEntity>>
      getAllServicesCenter(
          {String? name,
          String? category,
          String? ownerId,
          String? serviceCenterId,
          String? serviceId,
          bool? aroundMe,
          bool? availableNow}) async {
    try {
      final response = await networkService
          .post(WorkshopConstants.getAllServicesCenterGetUri, body: {
        'name': name,
        'category': category,
        'ownerId': ownerId,
        // 'serviceId': serviceId,
        'serviceCenterId': serviceCenterId,
        // 'aroundMe': aroundMe,
        // 'availableNow': availableNow
      });
      return Right(GetAllServicesCenterModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<WorkshopException, GetAllServiceCenterServicesEntity>>
      getAllServicesCenterServices(String serviceCenterId) async {
    try {
      final response = await networkService.get(
          '${WorkshopConstants.getServiceCenterGetUri}/$serviceCenterId${WorkshopConstants.services}');
      return Right(
          GetAllServiceCenterServicesModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message, e.statusCode));
    }
  }

  // @override
  // Future<Either<WorkshopException, GetAllServiceCenterServicesEntity>>
  //     getAllServicesCenterServices(String serviceCenterId) async {
  //   try {
  //     final response = await networkService.get(
  //         '${WorkshopConstants.getServiceCenterGetUri}/$serviceCenterId${WorkshopConstants.services}');
  //     return Right(
  //         GetAllServiceCenterServicesModel.fromJson(response).toEntity());
  //   } on BaseException catch (e) {
  //     return Left(WorkshopException(e.message, e.statusCode));
  //   }
  // }

  @override
  Future<Either<WorkshopException, GetAllServiceCenterServicesEntity>>
      getAllAvailableServicesCenterServices(String serviceCenterId) async {
    try {
      final response = await networkService.get(
          '${WorkshopConstants.getServiceCenterGetUri}/$serviceCenterId${WorkshopConstants.availableServices}');
      return Right(
          GetAllServiceCenterServicesModel.fromJson(response).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message, e.statusCode));
    }
  }

  // 1. Autocomplete → gets a list of { description, place_id }
  @override
  Future<Either<WorkshopException, List<PlacePrediction>>> fetchAutocomplete(
      String input) async {
    final Dio dio = Dio();

    try {
      final k = GarageConstants.apiKey;
      final response = await dio
          .post(WorkshopConstants.googleAutocompleteUri, queryParameters: {
        'input': input,
        'key': k,
        'components': 'country:cm',
      });
      // print(response);
      return Right((response.data['predictions'] as List)
          .map((p) => PlacePredictionModel.fromJson(p).toEntity())
          .toList());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<WorkshopException, PlaceDetails>> fetchPlaceDetails(
      String placeId) async {
    final Dio dio = Dio();

    try {
      final k = GarageConstants.apiKey;
      final response = await dio
          .post(WorkshopConstants.googlePlaceDetailsUri, queryParameters: {
        'place_id': placeId,
        'key': k,
        'fields': 'formatted_address,geometry',
      });
      return Right(
          PlaceDetailsModel.fromJson(response.data['result']).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message, e.statusCode));
    }
  }

  //Add methods here
}
