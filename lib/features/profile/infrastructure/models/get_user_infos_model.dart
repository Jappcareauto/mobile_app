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
  final String? phoneCode;
  final String? phoneNumber;

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
    this.phoneCode,
    this.phoneNumber,
  });

  factory GetUserInfosModel.fromJson(Map<String, dynamic> json) {
    // Parse phone data.
    // New API format returns phones: [{code, number}, ...]
    // Legacy format returned phone: {code, number}
    String? phoneCode;
    String? phoneNumber;

    final dynamic phones = json['phones'];
    if (phones is List && phones.isNotEmpty) {
      final dynamic firstPhone = phones.first;
      if (firstPhone is Map) {
        phoneCode = firstPhone['code']?.toString();
        phoneNumber = firstPhone['number']?.toString();
      }
    } else if (json['phone'] != null && json['phone'] is Map) {
      phoneCode = json['phone']['code']?.toString();
      phoneNumber = json['phone']['number']?.toString();
    }

    return GetUserInfosModel._(
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      dateOfBirth: json['dateOfBirth']?.toString(),
      image: json['profileImageUrl']?.toString(),
      // verified: json['verified'],
      verified: true,
      id: json['id']?.toString() ?? '',
      createdBy: json['createdBy'] is String
          ? json['createdBy']
          : json['createdBy']?.toString(),
      updatedBy: json['updatedBy'] is String
          ? json['updatedBy']
          : json['updatedBy']?.toString(),
      createdAt: json['createdAt'] is String
          ? json['createdAt']
          : json['createdAt']?.toString(),
      updatedAt: json['updatedAt'] is String
          ? json['updatedAt']
          : json['updatedAt']?.toString(),
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      phoneCode: phoneCode,
      phoneNumber: phoneNumber,
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
      phoneCode: entity.phone?.code,
      phoneNumber: entity.phone?.number,
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
      phone: (phoneCode != null || phoneNumber != null)
          ? PhoneInfo(code: phoneCode, number: phoneNumber)
          : null,
    );
  }
}
