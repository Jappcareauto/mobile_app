class UpdateVehicleCommand {
  final String id;
  final String name;
  final String garageId;
  final String vin;
  final String registrationNumber;
  final String? description;

  const UpdateVehicleCommand({
    required this.id,
    required this.name,
    required this.garageId,
    required this.vin,
    required this.registrationNumber,
    this.description,
  });
}
