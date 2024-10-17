import '../../domain/entities/login.dart';

class LoginModel {

  final String accessToken;
  final String refreshToken;
  final int expiry;

  LoginModel._({
    required this.accessToken,
    required this.refreshToken,
    required this.expiry,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel._(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      expiry: json['expiry'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['expiry'] = expiry;
    return data;
  }

  factory LoginModel.fromEntity(Login entity) {
    return LoginModel._(
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
      expiry: entity.expiry,
    );
  }

  Login toEntity() {
    return Login.create(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiry: expiry,
    );
  }
}
