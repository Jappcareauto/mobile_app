class BookAppointmentCommand {
  final String date;
  final String locationType;
  final String note;
  final String serviceId;
  final String vehicleId;
  final String timeOfDay;
  final String serviceCenterId;
  final String createdBy;

  BookAppointmentCommand({
    required this.timeOfDay,
    required this.locationType,
    required this.note,
    required this.serviceId,
    required this.vehicleId,
    required this.date,
    required this.serviceCenterId,
    required this.createdBy,
  });
}
