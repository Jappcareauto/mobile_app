import '../../domain/entities/register.dart';

class RegisterModel {

  final String name;
  final String email;
  final bool verified;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  RegisterModel._({
    required this.name,
    required this.email,
    required this.verified,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel._(
      name: json['name'],
      email: json['email'],
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
    data['verified'] = verified;
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory RegisterModel.fromEntity(Register entity) {
    return RegisterModel._(
      name: entity.name,
      email: entity.email,
      verified: entity.verified,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Register toEntity() {
    return Register.create(
      name: name,
      email: email,
      verified: verified,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
