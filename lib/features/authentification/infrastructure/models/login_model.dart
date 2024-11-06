import '../../domain/entities/login.dart';

class LoginModel {

  final String accessToken;
  final String refreshToken;

  LoginModel._({
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel._(
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

  factory LoginModel.fromEntity(Login entity) {
    return LoginModel._(
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
    );
  }

  Login toEntity() {
    return Login.create(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
