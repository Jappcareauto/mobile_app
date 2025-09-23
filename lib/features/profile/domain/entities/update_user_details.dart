class UpdateUserDetails {

  final bool state;
  final String? message;

  UpdateUserDetails._({
    required this.state,
    this.message,
  });

  factory UpdateUserDetails.create({
    required bool state,
    String? message,
  }) {
    return UpdateUserDetails._(
      state: state,
      message: message,
    );
  }
}
