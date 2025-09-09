class UpdateProfileCommand {
  final String name;
  final String email;
  final String dateOfBirth;
  final String? address;
  final String? phone;

  UpdateProfileCommand(
      {required this.name, required this.email, required this.dateOfBirth, this.address, this.phone});
}