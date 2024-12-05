import '../../domain/entities/reset_password.dart';

class ResetPasswordModel {

  final String accessToken;
  final String refreshToken;

  ResetPasswordModel._({
    required this.accessToken,
    required this.refreshToken,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel._(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }

  factory ResetPasswordModel.fromEntity(ResetPassword entity) {
    return ResetPasswordModel._(
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
    );
  }

  ResetPassword toEntity() {
    return ResetPassword.create(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
