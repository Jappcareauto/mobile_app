import 'package:jappcare/core/ui/domain/entities/location.entity.dart';

class LocationModel {
  final String? id;
  final String? name;
  final double? latitude;
  final double? longitude;
  final String? description;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;

  LocationModel._(
      {this.id,
      this.name,
      this.latitude,
      this.longitude,
      this.description,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel._(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['description'] = description;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  LocationModel copyWith({
    String? id,
    String? name,
    double? latitude,
    double? longitude,
    String? description,
    String? createdBy,
    String? updatedBy,
    String? createdAt,
    String? updatedAt,
  }) {
    return LocationModel._(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory LocationModel.fromEntity(LocationEntity entity) {
    return LocationModel._(
      id: entity.id,
      name: entity.name,
      latitude: entity.latitude,
      longitude: entity.longitude,
      description: entity.description,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  LocationEntity toEntity() {
    return LocationEntity.create(
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
}
