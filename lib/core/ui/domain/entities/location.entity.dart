import 'package:jappcare/core/ui/domain/models/location.model.dart';

class LocationEntity {
  final String? id;
  final String? name;
  final double? latitude;
  final double? longitude;
  final String? description;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;

  LocationEntity._({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LocationEntity.create({
    required name,
    required latitude,
    required longitude,
    required description,
    required id,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return LocationEntity._(
      name: name,
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

  LocationModel toModel() {
    return LocationModel.fromEntity(this);
  }
}
