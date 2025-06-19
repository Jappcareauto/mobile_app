class AddVehicleCommand {
  final String serviceCenterId;
  final String vin;
  final String registrationNumber;

  const AddVehicleCommand({
    required this.serviceCenterId,
    required this.vin,
    required this.registrationNumber,
  });
}
