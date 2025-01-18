import '../../domain/entities/emergency.dart';

class EmergencyModel {

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

  EmergencyModel._({
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

  factory EmergencyModel.fromJson(Map<String, dynamic> json) {
    return EmergencyModel._(
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

  factory EmergencyModel.fromEntity(Emergency entity) {
    return EmergencyModel._(
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

  Emergency toEntity() {
    return Emergency.create(
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
class LocationModel {

  final int latitude;
  final int longitude;
  final String description;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  LocationModel._({
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel._(
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['description'] = description;
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory LocationModel.fromEntity(Location entity) {
    return LocationModel._(
      latitude: entity.latitude,
      longitude: entity.longitude,
      description: entity.description,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Location toEntity() {
    return Location.create(
      latitude: latitude,
      longitude: longitude,
      description: description,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
