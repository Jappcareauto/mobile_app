class Login {

  final String accessToken;
  final String refreshToken;

  Login._({
    required this.accessToken,
    required this.refreshToken
  });

  factory Login.create({
    required accessToken,
    required refreshToken
  }) {
    // Add any validation or business logic here
    return Login._(
      accessToken: accessToken,
      refreshToken: refreshToken
    );
  }

}
