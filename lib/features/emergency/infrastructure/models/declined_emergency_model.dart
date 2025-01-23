import 'package:jappcare/features/emergency/infrastructure/models/emergency_model.dart';

import '../../domain/entities/emergency.dart';
import '../../domain/entities/declined_emergency.dart';

class DeclinedEmergencyModel {

  final String serviceCenterId;
  final String vehicleId;
  final String title;
  final String note;
  final String status;
  final LocationModel location;
  final String id;
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String updatedBy;

  DeclinedEmergencyModel._({
    required this.serviceCenterId,
    required this.vehicleId,
    required this.title,
    required this.note,
    required this.status,
    required this.location,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
  });

  factory DeclinedEmergencyModel.fromJson(Map<String, dynamic> json) {
    return DeclinedEmergencyModel._(
      serviceCenterId: json['serviceCenterId'],
      vehicleId: json['vehicleId'],
      title: json['title'],
      note: json['note'],
      status: json['status'],
      location: LocationModel.fromJson(json['location']),
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceCenterId'] = serviceCenterId;
    data['vehicleId'] = vehicleId;
    data['title'] = title;
    data['note'] = note;
    data['status'] = status;
    data['location'] = location.toJson();
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    return data;
  }

  factory DeclinedEmergencyModel.fromEntity(DeclinedEmergency entity) {
    return DeclinedEmergencyModel._(
      serviceCenterId: entity.serviceCenterId,
      vehicleId: entity.vehicleId,
      title: entity.title,
      note: entity.note,
      status: entity.status,
      location: LocationModel.fromEntity(entity.location),
      id: entity.id,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
    );
  }

  DeclinedEmergency toEntity() {
    return DeclinedEmergency.create(
      serviceCenterId: serviceCenterId,
      vehicleId: vehicleId,
      title: title,
      note: note,
      status: status,
      location: location.toEntity(),
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      createdBy: createdBy,
      updatedBy: updatedBy,
    );
  }
}
