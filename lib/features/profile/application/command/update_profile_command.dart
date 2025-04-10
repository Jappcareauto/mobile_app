class UpdateProfileCommand {
  final String name;
  final String email;
  final String? address;
  final String? phone;

  UpdateProfileCommand(
      {required this.name, required this.email, this.address, this.phone});
}
