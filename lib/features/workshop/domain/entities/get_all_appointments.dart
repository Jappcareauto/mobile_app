import 'package:jappcare/core/ui/domain/entities/location.entity.dart';
import 'package:jappcare/core/ui/domain/entities/pagination.entity.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room.entity.dart';
import 'package:jappcare/features/garage/domain/entities/get_vehicle_list.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services.entity.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_services_center.entity.dart';
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
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final String? status;
  final String? note;
  final String? timeOfDay;
  final String date;
  final String locationType;
  final LocationEntity? location;
  final ServiceEntity? service;
  final ServiceCenterEntity? serviceCenter;
  final Vehicle? vehicle;
  final String? diagnosesToMake;
  final String? diagnosesMade;
  final ChatRoomEntity? chatRoom;

  AppointmentEntity._(
      {required this.id,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.note,
      this.timeOfDay,
      required this.date,
      required this.locationType,
      this.location,
      this.service,
      this.serviceCenter,
      this.chatRoom,
      this.vehicle,
      this.diagnosesToMake,
      this.diagnosesMade});

  factory AppointmentEntity.create(
      {required String id,
      LocationEntity? location,
      String? createdBy,
      String? updatedBy,
      String? createdAt,
      String? updatedAt,
      String? status,
      String? note,
      String? timeOfDay,
      required String date,
      required String locationType,
      ServiceCenterEntity? serviceCenter,
      ServiceEntity? service,
      ChatRoomEntity? chatRoom,
      Vehicle? vehicle,
      String? diagnosesToMake,
      String? diagnosesMade}) {
    // Add any validation or business logic here
    return AppointmentEntity._(
        id: id,
        createdBy: createdBy,
        updatedBy: updatedBy,
        createdAt: createdAt,
        updatedAt: updatedAt,
        status: status,
        note: note,
        timeOfDay: timeOfDay,
        date: date,
        locationType: locationType,
        location: location,
        serviceCenter: serviceCenter,
        chatRoom: chatRoom,
        service: service,
        vehicle: vehicle,
        diagnosesToMake: diagnosesToMake,
        diagnosesMade: diagnosesMade);
  }

  String get formattedLocationType {
    return locationType.split('_').map((word) {
      return word.substring(0, 1).toUpperCase() +
          word.substring(1).toLowerCase();
    }).join(' ');
  }
}
