class ResetPasswordCommand {
  final String code;
  final String newPassword;

  const ResetPasswordCommand({
    required this.code,
    required this.newPassword,
  });
}

