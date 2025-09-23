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
    this.name,
    this.latitude,
    this.longitude,
    this.description,
    this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory LocationEntity.create({
    String? name,
    double? latitude,
    double? longitude,
    String? description,
    String? id,
    String? createdBy,
    String? updatedBy,
    String? createdAt,
    String? updatedAt,
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

  factory LocationEntity.fromModel(LocationModel model) {
    return LocationEntity.create(
      name: model.name,
      latitude: model.latitude,
      longitude: model.longitude,
      description: model.description,
      id: model.id,
      createdBy: model.createdBy,
      updatedBy: model.updatedBy,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;
    if (description != null) data['description'] = description;
    if (createdBy != null) data['createdBy'] = createdBy;
    if (updatedBy != null) data['updatedBy'] = updatedBy;
    if (createdAt != null) data['createdAt'] = createdAt;
    if (updatedAt != null) data['updatedAt'] = updatedAt;
    return data;
  }

  LocationModel toModel() {
    return LocationModel.fromEntity(this);
  }
}
