import 'package:jappcare/core/ui/domain/entities/location.entity.dart';

class PhoneInfo {
  final String? code;
  final String? number;

  PhoneInfo({this.code, this.number});
}

class GetUserInfos {

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
  final LocationEntity? location;
  final PhoneInfo? phone;

  GetUserInfos._({
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
    this.phone,
  });

  factory GetUserInfos.create({
    required String name,
    required String email,
    String? dateOfBirth,
    String? image,
    required bool verified,
    required String id,
    String? createdBy,
    String? updatedBy,
    String? createdAt,
    String? updatedAt,
    LocationEntity? location,
    PhoneInfo? phone,
  }) {
    // Add any validation or business logic here
    return GetUserInfos._(
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
      location: location,
      phone: phone,
    );
  }

}
