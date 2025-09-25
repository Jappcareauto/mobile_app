class GetAllAppointmentsCommand {
  final String? status;
  final String? vehicleId;
  final String? serviceCenterId;
  final String? userId;
  final String? locationType;

  GetAllAppointmentsCommand({
    this.status,
    this.vehicleId,
    this.serviceCenterId,
    this.userId,
    this.locationType,
  });
}
