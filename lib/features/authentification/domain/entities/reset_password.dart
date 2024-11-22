class ResetPassword {

  final String accessToken;
  final String refreshToken;

  ResetPassword._({
    required this.accessToken,
    required this.refreshToken,
  });

  factory ResetPassword.create({
    required accessToken,
    required refreshToken,
  }) {
    // Add any validation or business logic here
    return ResetPassword._(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

}
