class BookAppointmentCommand{
  final String date;
  final String locationType;
  final String note;
  final String serviceId;
  final String vehicleId;
  final String status;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;
  BookAppointmentCommand({
      required this.id,
    required this.locationType,
    required this.note,
    required this.serviceId,
    required this.vehicleId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.date,
    required this.updatedBy
});
}