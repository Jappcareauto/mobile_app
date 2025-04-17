import 'package:jappcare/core/ui/domain/models/location.model.dart';
import 'package:jappcare/core/ui/domain/models/pagination.model.dart';
import 'package:jappcare/features/garage/infrastructure/models/get_vehicle_list_model.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';
import 'package:jappcare/features/workshop/infrastructure/models/get_all_services_model.dart';

class GetAllAppointmentsModel {
  final List<AppointmentModel> data;
  final PaginationModel pagination;

  GetAllAppointmentsModel._({
    required this.data,
    required this.pagination,
  });

  factory GetAllAppointmentsModel.fromJson(Map<String, dynamic> json) {
    return GetAllAppointmentsModel._(
      data: List<AppointmentModel>.from(
          json['data'].map((x) => AppointmentModel.fromJson(x))),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['data'] = data
        .map((x) => x.toJson())
        .toList(); // Utilise la propriété `data` de la classe
    json['pagination'] = pagination.toJson();
    return json;
  }

  factory GetAllAppointmentsModel.fromEntity(GetAllAppointments entity) {
    return GetAllAppointmentsModel._(
      data: List<AppointmentModel>.from(
          entity.data.map((x) => AppointmentModel.fromEntity(x))),
      pagination: PaginationModel.fromEntity(entity.pagination),
    );
  }

  GetAllAppointments toEntity() {
    return GetAllAppointments.create(
      data: data.map((x) => x.toEntity()).toList(),
      pagination: pagination.toEntity(),
    );
  }
}

class AppointmentModel {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String? status;
  final String timeOfDay;
  final String date;
  final String locationType;
  final LocationModel? location;
  final ServiceModel? service;
  final VehicleModel? vehicle;

  AppointmentModel._({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.status,
    required this.timeOfDay,
    required this.date,
    required this.locationType,
    this.location,
    this.service,
    this.vehicle,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel._(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      status: json['status'],
      timeOfDay: json['timeOfDay'],
      date: json['date'],
      locationType: json['locationType'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      service: json['service'] != null
          ? ServiceModel.fromJson(json['service'])
          : null,
      vehicle: json['vehicle'] != null
          ? VehicleModel.fromJson(json['vehicle'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['status'] = status;
    data['timeOfDay'] = timeOfDay;
    data['date'] = date;
    data['locationType'] = locationType;
    data['location'] = location?.toJson();
    data['service'] = service?.toJson();
    data['vehicle'] = vehicle?.toJson();
    return data;
  }

  factory AppointmentModel.fromEntity(AppointmentEntity entity) {
    return AppointmentModel._(
      id: entity.id,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      status: entity.status,
      timeOfDay: entity.timeOfDay,
      date: entity.date,
      locationType: entity.locationType,
      location: entity.location?.toModel(),
      service: entity.service?.toModel(),
      vehicle: entity.vehicle?.toModel(),
    );
  }

  AppointmentEntity toEntity() {
    return AppointmentEntity.create(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      timeOfDay: timeOfDay,
      date: date,
      locationType: locationType,
      location: location?.toEntity(),
      service: service?.toEntity(),
      vehicle: vehicle?.toEntity(),
    );
  }
}
