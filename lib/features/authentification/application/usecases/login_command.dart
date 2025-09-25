import 'package:jappcare/features/authentification/application/usecases/register_command.dart';

class LoginCommand {
  final String? email;
  final PhoneCommand? phone;
  final String password;
  final bool? extend;

  const LoginCommand({
    this.email,
    this.phone,
    required this.password,
    this.extend,
  });
}
