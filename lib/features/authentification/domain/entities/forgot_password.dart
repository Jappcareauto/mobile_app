class ForgotPassword {

  final bool state;
  final String message;

  ForgotPassword._({
    required this.state,
    required this.message,
  });

  factory ForgotPassword.create({
    required state,
    required message,
  }) {
    // Add any validation or business logic here
    return ForgotPassword._(
      state: state,
      message: message,
    );
  }

}
