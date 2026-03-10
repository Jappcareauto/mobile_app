class ChangePasswordCommand {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordCommand({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}
