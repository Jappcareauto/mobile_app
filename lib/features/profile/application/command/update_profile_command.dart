import 'package:jappcare/core/ui/domain/entities/location.entity.dart';

class UpdateProfileCommand {
  final String name;
  final String email;
  final String dateOfBirth;
  final String? address;
  final LocationEntity? location;
  final String? phone;
  final String? phoneCode;

  UpdateProfileCommand(
      {required this.name, required this.email, this.location, required this.dateOfBirth, this.address, this.phoneCode, this.phone});
}