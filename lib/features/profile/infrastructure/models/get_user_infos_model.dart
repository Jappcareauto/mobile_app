import 'package:jappcare/core/ui/domain/models/location.model.dart';

import '../../domain/entities/get_user_infos.dart';

class GetUserInfosModel {
  final String name;
  final String email;
  final String? dateOfBirth;
  final String? image;
  final bool verified;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final LocationModel? location;

  GetUserInfosModel._({
    required this.name,
    required this.email,
    required this.dateOfBirth,
    this.image,
    required this.verified,
    required this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.location,
  });

  factory GetUserInfosModel.fromJson(Map<String, dynamic> json) {
    return GetUserInfosModel._(
      name: json['name'],
      email: json['email'],
      dateOfBirth: json['dateOfBirth'],
      image: json['profileImageUrl'],
      // verified: json['verified'],
      verified: true,
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    if (dateOfBirth != null) data['dateOfBirth'] = dateOfBirth;
    if (image != null) {
      data['profileImageUrl'] = image;
    }
    data['verified'] = verified;
    data['id'] = id;
    if (createdBy != null) {
      data['createdBy'] = createdBy;
    }
    if (updatedBy != null) {
      data['updatedBy'] = updatedBy;
    }
    if (createdAt != null) {
      data['createdAt'] = createdAt;
    }
    if (updatedAt != null) {
      data['updatedAt'] = updatedAt;
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }

  factory GetUserInfosModel.fromEntity(GetUserInfos entity) {
    return GetUserInfosModel._(
      name: entity.name,
      email: entity.email,
      dateOfBirth: entity.dateOfBirth,
      image: entity.image,
      verified: entity.verified,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      location: entity.location?.toModel(),
    );
  }

  GetUserInfos toEntity() {
    return GetUserInfos.create(
      name: name,
      email: email,
      dateOfBirth: dateOfBirth,
      image: image,
      verified: verified,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      location: location?.toEntity(),
    );
  }
}