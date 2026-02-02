import 'package:jappcare/features/profile/domain/entities/update_user_details.dart';

class UpdateUserDetailsModel {
  final bool state;
  final String? message;
  final String? id;
  final String? name;
  final String? email;
  final String? profileImageUrl;
  final String? dateOfBirth;

  UpdateUserDetailsModel._({
    required this.state,
    this.message,
    this.id,
    this.name,
    this.email,
    this.profileImageUrl,
    this.dateOfBirth,
  });

  factory UpdateUserDetailsModel.fromJson(Map<String, dynamic> json) {
    // Handle new API response format which returns user data with 'id' field
    if (json.containsKey('id')) {
      return UpdateUserDetailsModel._(
        state: true,
        message: 'User details updated successfully.',
        id: json['id'],
        name: json['name'],
        email: json['email'],
        profileImageUrl: json['profileImageUrl'],
        dateOfBirth: json['dateOfBirth'],
      );
    }
    // Fallback for old format with state/message
    return UpdateUserDetailsModel._(
      state: json['state'] ?? true,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'message': message,
      'id': id,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'dateOfBirth': dateOfBirth,
    };
  }

  factory UpdateUserDetailsModel.fromEntity(UpdateUserDetails entity) {
    return UpdateUserDetailsModel._(
      state: entity.state,
      message: entity.message,
    );
  }

  UpdateUserDetails toEntity() {
    return UpdateUserDetails.create(
      state: state,
      message: message,
    );
  }
}
