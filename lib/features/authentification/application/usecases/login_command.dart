class LoginCommand {

  final String email;
  final String password;
  final bool? extend;

  const LoginCommand({
    required this.email,
    required this.password,
    this.extend,
  });
}

