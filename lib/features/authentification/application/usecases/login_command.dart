class LoginCommand {
  final String? email;
  final String? phone;
  final String password;
  final bool? extend;

  const LoginCommand({
    this.email,
    this.phone,
    required this.password,
    this.extend,
  });
}
