import 'package:jappcare/core/ui/domain/entities/location.entity.dart';
import 'package:jappcare/features/authentification/application/usecases/phone_command.dart';

class UpdateProfileCommand {
  final String name;
  final String email;
  final String dateOfBirth;
  final String? address;
  final LocationEntity? location;
  final PhoneCommand? phone;

  UpdateProfileCommand(
      {required this.name, required this.email, this.location, required this.dateOfBirth, this.address, this.phone});
}