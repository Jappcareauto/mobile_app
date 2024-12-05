import '../../domain/entities/forgot_password.dart';

class ForgotPasswordModel {

  final bool state;
  final String message;

  ForgotPasswordModel._({
    required this.state,
    required this.message,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel._(
      state: json['state'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['message'] = message;
    return data;
  }

  factory ForgotPasswordModel.fromEntity(ForgotPassword entity) {
    return ForgotPasswordModel._(
      state: entity.state,
      message: entity.message,
    );
  }

  ForgotPassword toEntity() {
    return ForgotPassword.create(
      state: state,
      message: message,
    );
  }
}
