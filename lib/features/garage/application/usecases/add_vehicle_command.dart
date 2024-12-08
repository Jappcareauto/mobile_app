class AddVehicleCommand {

  final String garageId;
  final String vin;
  final String registrationNumber;

  const AddVehicleCommand({
    required this.garageId,
    required this.vin,
    required this.registrationNumber,
  });
}

