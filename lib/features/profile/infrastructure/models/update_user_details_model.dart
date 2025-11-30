import 'package:jappcare/features/profile/domain/entities/update_user_details.dart';

class UpdateUserDetailsModel {
  final bool state;
  final String? message;

  UpdateUserDetailsModel._({
    required this.state,
    this.message,
  });

  factory UpdateUserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UpdateUserDetailsModel._(
      state: json['state'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'message': message,
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
