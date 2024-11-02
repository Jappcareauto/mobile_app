import '../../domain/entities/get_user_infos.dart';

class GetUserInfosModel {

  final String name;
  final String email;
  final String? image;
  final bool verified;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;

  GetUserInfosModel._({
    required this.name,
    required this.email,
    this.image,
    required this.verified,
    required this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory GetUserInfosModel.fromJson(Map<String, dynamic> json) {
    return GetUserInfosModel._(
      name: json['name'],
      email: json['email'],
      image: json['profileImageUrl'],
      verified: json['verified'],
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
    data['email'] = email;
    if (image != null) { data['profileImageUrl'] = image; }
    data['verified'] = verified;
    data['id'] = id;
    if (createdBy != null) { data['createdBy'] = createdBy; }
    if (updatedBy != null) { data['updatedBy'] = updatedBy; }
    if (createdAt != null) { data['createdAt'] = createdAt; }
    if (updatedAt != null) { data['updatedAt'] = updatedAt; }
    return data;
  }

  factory GetUserInfosModel.fromEntity(GetUserInfos entity) {
    return GetUserInfosModel._(
      name: entity.name,
      email: entity.email,
      image: entity.image,
      verified: entity.verified,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  GetUserInfos toEntity() {
    return GetUserInfos.create(
      name: name,
      email: email,
      image: image,
      verified: verified,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
