import 'package:jappcare/features/authentification/application/usecases/phone_command.dart';

class RegisterCommand {
  final String name;
  final String? email;
  final String password;
  final PhoneCommand? phone;
  final String dateOfBirth;

  const RegisterCommand({
    required this.name,
    this.email,
    required this.password,
    this.phone,
    required this.dateOfBirth,
  });
}

