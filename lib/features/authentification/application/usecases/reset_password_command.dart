class ResetPasswordCommand {
  final String code;
  final String email;
  final String newPassword;

  const ResetPasswordCommand({
    required this.code,
    required this.email,
    required this.newPassword,
  });
}
