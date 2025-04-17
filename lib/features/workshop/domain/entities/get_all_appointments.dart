import 'package:jappcare/core/ui/domain/entities/location.entity.dart';
import 'package:jappcare/core/ui/domain/entities/pagination.entity.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services.dart';
// import 'package:jappcare/features/workshop/domain/entities/get_vehicule_by_id.dart';

class GetAllAppointments {
  final List<AppointmentEntity> data;
  final Pagination pagination;

  GetAllAppointments._({
    required this.data,
    required this.pagination,
  });

  factory GetAllAppointments.create({
    required data,
    required pagination,
  }) {
    // Add any validation or business logic here
    return GetAllAppointments._(
      data: data,
      pagination: pagination,
    );
  }
}

class AppointmentEntity {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String? status;
  final String timeOfDay;
  final String date;
  final String locationType;
  final LocationEntity? location;
  final ServiceEntity? service;
  final Vehicle? vehicle;

  AppointmentEntity._(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.status,
      required this.timeOfDay,
      required this.date,
      required this.locationType,
      required this.location,
      required this.service,
      required this.vehicle});

  factory AppointmentEntity.create(
      {required id,
      required location,
      required createdAt,
      required updatedAt,
      status,
      required timeOfDay,
      required date,
      required locationType,
      required service,
      required vehicle}) {
    // Add any validation or business logic here
    return AppointmentEntity._(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        status: status,
        timeOfDay: timeOfDay,
        date: date,
        locationType: locationType,
        location: location,
        service: service,
        vehicle: vehicle);
  }
}
