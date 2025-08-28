class AddVehicleCommand {
  final String userId;
  final String vin;
  final String registrationNumber;

  const AddVehicleCommand({
    required this.userId,
    required this.vin,
    required this.registrationNumber,
  });
}
