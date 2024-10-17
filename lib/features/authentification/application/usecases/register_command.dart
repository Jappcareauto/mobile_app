class RegisterCommand {

  final String name;
  final String email;
  final String password;
  final PhoneCommand phone;
  final String dateOfBirth;

  const RegisterCommand({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.dateOfBirth,
  });
}

class PhoneCommand {

  final String code;
  final String number;

  const PhoneCommand({
    required this.code,
    required this.number,
  });
}

