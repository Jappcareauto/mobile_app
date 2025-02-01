class BookAppointment {

  final String date;
  final String locationType;
  final String note;
  final String serviceId;
  final String vehicleId;
  final String status;
  final String timeOfDay;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  BookAppointment._({
    required this.date,
    required  this.timeOfDay,
    required this.locationType,
    required this.note,
    required this.serviceId,
    required this.vehicleId,
    required this.status,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookAppointment.create({
    required date,
    required locationType,
    required note,
    required serviceId,
    required vehicleId,
    required status,
    required id,
    required timeOfDay,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return BookAppointment._(
      date: date,
      locationType: locationType,
      note: note,
      serviceId: serviceId,
      vehicleId: vehicleId,
      status: status,
      timeOfDay: timeOfDay,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

}
