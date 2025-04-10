class BookAppointmentCommand{
  final String date;
  final String locationType;
  final String note;
  final String serviceId;
  final String vehicleId;
  final String status;
  final String timeOfDay;
  BookAppointmentCommand({

    required this.timeOfDay,
    required this.locationType,
    required this.note,
    required this.serviceId,
    required this.vehicleId,
    required this.status,
    required this.date,

});
}