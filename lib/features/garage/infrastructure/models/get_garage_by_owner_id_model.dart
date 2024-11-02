import '../../domain/entities/get_garage_by_owner_id.dart';

class GetGarageByOwnerIdModel {

  final String name;
  final String ownerId;
  final String? location;
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
      location: json['location'],
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
    if (location != null) { data['location'] = location; }
    data['id'] = id;
    if (createdBy != null) { data['createdBy'] = createdBy; }
    if (updatedBy != null) { data['updatedBy'] = updatedBy; }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory GetGarageByOwnerIdModel.fromEntity(GetGarageByOwnerId entity) {
    return GetGarageByOwnerIdModel._(
      name: entity.name,
      ownerId: entity.ownerId,
      location: entity.location,
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
      location: location,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
