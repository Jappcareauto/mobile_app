class Login {

  final String accessToken;
  final String refreshToken;
  final int expiry;

  Login._({
    required this.accessToken,
    required this.refreshToken,
    required this.expiry,
  });

  factory Login.create({
    required accessToken,
    required refreshToken,
    required expiry,
  }) {
    // Add any validation or business logic here
    return Login._(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiry: expiry,
    );
  }

}
