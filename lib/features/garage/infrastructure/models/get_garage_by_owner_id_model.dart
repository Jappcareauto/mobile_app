import '../../domain/entities/get_garage_by_owner_id.dart';
import './location_model.dart';

class GetGarageByOwnerIdModel {
  final String name;
  final String ownerId;
  final LocationModel? location; // Utilisation du sous-modèle
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;

  GetGarageByOwnerIdModel._({
    required this.name,
    required this.ownerId,
    this.location,
    required this.id,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetGarageByOwnerIdModel.fromJson(Map<String, dynamic> json) {
    return GetGarageByOwnerIdModel._(
      name: json['name'],
      ownerId: json['ownerId'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['ownerId'] = ownerId;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['id'] = id;
    if (createdBy != null) {
      data['createdBy'] = createdBy;
    }
    if (updatedBy != null) {
      data['updatedBy'] = updatedBy;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory GetGarageByOwnerIdModel.fromEntity(GetGarageByOwnerId entity) {
    return GetGarageByOwnerIdModel._(
      name: entity.name,
      ownerId: entity.ownerId,
      location: entity.location != null
          ? LocationModel(
        latitude: entity.location!.latitude,
        longitude: entity.location!.longitude,
        description: entity.location!.description,
        id: entity.location!.id,
        createdBy: entity.location!.createdBy,
        updatedBy: entity.location!.updatedBy,
        createdAt: entity.location!.createdAt,
        updatedAt: entity.location!.updatedAt,
      )
          : null,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  GetGarageByOwnerId toEntity() {
    return GetGarageByOwnerId.create(
      name: name,
      ownerId: ownerId,
      location: location, // Passez directement l'objet LocationModel ici
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

}
