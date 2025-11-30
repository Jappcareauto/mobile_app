//Don't translate me
import 'package:dio/dio.dart';
import 'package:jappcare/core/ui/domain/entities/location.entity.dart';
import 'package:jappcare/features/garage/domain/core/utils/garage_constants.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:jappcare/features/garage/infrastructure/models/get_vehicle_list_model.dart';
import 'package:jappcare/features/workshop/domain/entities/geocode_position.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_service_center_services.entity.dart';
import 'package:jappcare/features/workshop/domain/entities/place_details.dart';
import 'package:jappcare/features/workshop/infrastructure/models/get_all_appointments_model.dart';
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

import '../../domain/entities/get_all_services.entity.dart';
import '../models/get_all_services_model.dart';
import '../models/get_all_service_center_services_model.dart';

void printWrapped(String text) {
  // 800 is a good chunk size that should prevent truncation.
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

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
  Future<Either<WorkshopException, AppointmentEntity>> bookAppointment({
    required String date,
    required String locationType,
    LocationEntity? location,
    String? note,
    required String serviceId,
    required String vehicleId,
    required String timeOfDay,
    required String selectedTimeRange,
    required String createdBy,
    required String serviceCenterId,
  }) async {
    try {
      final response = await networkService.post(
        WorkshopConstants.bookAppointmentPostUri,
        body: {
          // 'id': "",
          "createdBy": createdBy,
          "updatedBy": createdBy,
          "createdAt": date,
          "updatedAt": date,
          'date': date,
          // 'location': null,
          if (location != null && locationType == "HOME")
            'location': location.toJson(),
          'locationType': locationType,
          'note': note,
          'serviceId': serviceId,
          'serviceCenterId': serviceCenterId,
          'vehicleId': vehicleId,
          'status': "NOT_STARTED",
          'timeOfDay': timeOfDay,
        },
      );
      return Right(AppointmentModel.fromJson(response["data"]).toEntity());
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
    } catch (e) {
      print(e);
      return Left(WorkshopException(e.toString(), 500));
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
      String input, String sessionToken) async {
    final Dio dio = Dio();

    try {
      final k = GarageConstants.apiKey;
      final response = await dio
          .post(WorkshopConstants.googleAutocompleteUri, queryParameters: {
        'input': input,
        'key': k,
        'sessiontoken': sessionToken,
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
      String placeId, String sessionToken) async {
    final Dio dio = Dio();

    try {
      final k = GarageConstants.apiKey;
      final response = await dio
          .post(WorkshopConstants.googlePlaceDetailsUri, queryParameters: {
        'place_id': placeId,
        'key': k,
        'sessiontoken': sessionToken,
        'fields': 'formatted_address,geometry',
      });
      return Right(
          PlaceDetailsModel.fromJson(response.data['result']).toEntity());
    } on BaseException catch (e) {
      return Left(WorkshopException(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<WorkshopException, GeocodePosition>> getAddressFromLatLng(
      double latitude, double longitude) async {
    final Dio dio = Dio();

    try {
      final k = GarageConstants.apiKey;
      final response =
          await dio.get(WorkshopConstants.googleGeocodeUri, queryParameters: {
        'latlng': '$latitude,$longitude',
        'key': k,
      });

      printWrapped('Geocode response: ${response.data['results'][0]}');

      var data = response.data['results'];
      if (data == null || data.isEmpty) {
        return Left(WorkshopException('No address found', 404));
      }

      return Right(GeocodePosition.fromJson(response.data['results'][0]));
    } on BaseException catch (e) {
      print(e);
      return Left(WorkshopException(e.message, e.statusCode));
    }
  }
}
