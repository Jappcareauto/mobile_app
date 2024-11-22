class ResetPasswordCommand {

  final String email;
  final String code;
  final String newPassword;

  const ResetPasswordCommand({
    required this.email,
    required this.code,
    required this.newPassword,
  });
}

